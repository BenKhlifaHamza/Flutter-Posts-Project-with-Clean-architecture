import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/add_delete_update_post/add_delete_update_bloc.dart';
import '../../pages/posts_page.dart';
import '../shared_widgets/loading_widgets.dart';
import '../shared_widgets/snack_bar.dart';
import 'delete_dialog_widget.dart';

class DeletePostWidget extends StatelessWidget {
  final int postId;
  const DeletePostWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    void deliteDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) =>
              BlocConsumer<AddDeleteUpdateBloc, AddDeleteUpdateState>(
                listener: (_, state) {
                  if (state is SuccessAddDeleteUpdateState) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const PostsPage()));
                    SnackBarWidget.showSuccessSnackBar(
                        msgSuc: state.msgSuc, context: context);
                  } else if (state is ErrorAddDeleteUpdateState) {
                    Navigator.of(context).pop();
                    SnackBarWidget.showErrorSnackBar(
                        msgErr: state.msgErr, context: context);
                  }
                },
                builder: (_, state) {
                  if (state is LoadingAddDeleteUpdateState) {
                    return const AlertDialog(
                      content: LoadingWidget(),
                    );
                  }

                  return DeleteDialogWidget(
                    postId: postId,
                  );
                },
              ));
    }

    return ElevatedButton.icon(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.red)),
        onPressed: () => deliteDialog(context),
        icon: const Icon(Icons.delete),
        label: const Text("Delete"));
  }
}
