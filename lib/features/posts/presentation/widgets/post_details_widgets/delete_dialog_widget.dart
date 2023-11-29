import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/add_delete_update_post/add_delete_update_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int postId;
  const DeleteDialogWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are YouSure ?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("No")),
        TextButton(
            onPressed: () {
              BlocProvider.of<AddDeleteUpdateBloc>(context)
                  .add(DeletePostEvent(postId: postId));
            },
            child: const Text("Yes"))
      ],
    );
  }
}
