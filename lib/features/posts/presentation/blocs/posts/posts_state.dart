part of 'posts_bloc.dart';

sealed class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class InitialPostsState extends PostsState {}

final class LoadingPostsState extends PostsState {}

final class LoadedPostsState extends PostsState {
  final List<PostEntitie> posts;

  const LoadedPostsState({required this.posts});

  @override
  List<Object> get props => [posts];
}

final class ErrorPostsState extends PostsState {
  final String msgErr;

  const ErrorPostsState({required this.msgErr});

  @override
  List<Object> get props => [msgErr];
}
