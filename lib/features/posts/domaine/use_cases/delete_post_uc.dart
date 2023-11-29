import '../../../../core/errors/failures.dart';
import '../repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePostUC {
  final PostsRepository _postsRepository;

  DeletePostUC(this._postsRepository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await _postsRepository.deletePost(postId);
  }
}
