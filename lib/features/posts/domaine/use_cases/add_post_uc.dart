import '../../../../core/errors/failures.dart';
import '../entities/post_entitie.dart';
import '../repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class AddPostUC {
  final PostsRepository _postsRepository;
  AddPostUC(this._postsRepository);

  Future<Either<Failure, Unit>> call(PostEntitie postEntitie) async {
    return await _postsRepository.addPost(postEntitie);
  }
}
