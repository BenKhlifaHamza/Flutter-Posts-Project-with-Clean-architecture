import '../../../../core/errors/failures.dart';
import '../entities/post_entitie.dart';
import 'package:dartz/dartz.dart';

abstract class PostsRepository {
  Future<Either<Failure, List<PostEntitie>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int postId);
  Future<Either<Failure, Unit>> updatePost(PostEntitie postEntitie);
  Future<Either<Failure, Unit>> addPost(PostEntitie postEntitie);
}
