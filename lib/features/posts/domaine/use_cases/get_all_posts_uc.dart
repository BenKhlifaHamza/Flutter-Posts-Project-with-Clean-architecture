import '../../../../core/errors/failures.dart';
import '../entities/post_entitie.dart';
import '../repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUC {
  final PostsRepository postsRepository;

  GetAllPostsUC({required this.postsRepository});

  //El "call()"" mawjouda par defaut f ay class, 3malna 3leha override bech
  //najmo na3mlo appel b essm l class : "GetAllPostsUC()" wala GetAllPostsUC.call().
  Future<Either<Failure, List<PostEntitie>>> call() async {
    return await postsRepository.getAllPosts();
  }
}
