import '../blocs/posts/posts_bloc.dart';
import 'add_update_page.dart';
import '../widgets/posts_widgets/posts_list_widget.dart';
import '../widgets/shared_widgets/error_message_widget.dart';
import '../widgets/shared_widgets/loading_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingActionButton(context),
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: const Text("Posts"),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        if (state is LoadingPostsState) {
          return const LoadingWidget();
        } else if (state is LoadedPostsState) {
          return RefreshIndicator(
              child: PostsListWidget(
                postsList: state.posts,
              ),
              onRefresh: () => _onRefresh(context));
        } else if (state is ErrorPostsState) {
          return ErrorMessageWidget(
            message: state.msgErr,
          );
        }
        return const LoadingWidget();
      }),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const AddUpdatePage(isUpdate: false)));
        },
        child: const Icon(Icons.add));
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
