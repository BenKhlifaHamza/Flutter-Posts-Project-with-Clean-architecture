import '../../../../../core/errors/failures.dart';
import '../../../../../core/errors/failures_messages.dart';
import '../../../domaine/use_cases/get_all_posts_uc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domaine/entities/post_entitie.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUC getAllPostsUC;
  PostsBloc({required this.getAllPostsUC}) : super(InitialPostsState()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPostsUC.call();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final failureOrPosts = await getAllPostsUC.call();
        emit(_mapFailureOrPostsToState(failureOrPosts));
      }
    });
  }

  PostsState _mapFailureOrPostsToState(
      Either<Failure, List<PostEntitie>> failureOrPosts) {
    return failureOrPosts.fold(
        (failure) => ErrorPostsState(msgErr: _mapFailureToMessage(failure)),
        (posts) => LoadedPostsState(posts: posts));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return FailureMessages.serverFailureMessage;
      case EmptyCacheFailure:
        return FailureMessages.emptyCacheFailureMessage;
      case OfflineFailure:
        return FailureMessages.offlineFailureMessage;

      default:
        return "Unexpected failure, Please try again later.";
    }
  }
}
