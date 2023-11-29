import '../../../../core/errors/failures.dart';
import '../../../../core/exceptions/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../api/posts_local_data_source.dart';
import '../api/posts_remote_data_source.dart';
import '../models/post_model.dart';
import '../../domaine/entities/post_entitie.dart';
import '../../domaine/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

typedef DelORupdORadd = Future<Unit> Function();

class PostRepositoryImp implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImp(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, List<PostEntitie>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.saveLocalPosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(PostEntitie postEntitie) async {
    final PostModel postModel =
        PostModel(title: postEntitie.title, body: postEntitie.body);

    return await _getMessage(
      () => remoteDataSource.addPost(postModel),
    );
  }

  @override
  Future<Either<Failure, Unit>> updatePost(PostEntitie postEntitie) async {
    final PostModel postModel = PostModel(
        id: postEntitie.id, title: postEntitie.title, body: postEntitie.body);

    return await _getMessage(
      () => remoteDataSource.updatePost(postModel),
    );
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return _getMessage(
      () => remoteDataSource.deletePost(postId),
    );
  }

  Future<Either<Failure, Unit>> _getMessage(DelORupdORadd delORupdORadd) async {
    if (await networkInfo.isConnected) {
      try {
        await delORupdORadd();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
