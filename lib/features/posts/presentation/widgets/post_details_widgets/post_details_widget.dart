import '../../../domaine/entities/post_entitie.dart';
import 'delete_post_widget.dart';
import 'update_post_button.dart';

import 'package:flutter/material.dart';

class PostDetailsWidget extends StatelessWidget {
  final PostEntitie postEntitie;
  const PostDetailsWidget({super.key, required this.postEntitie});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          postEntitie.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Divider(
          height: 50,
        ),
        Text(
          postEntitie.body,
          style: const TextStyle(fontSize: 16),
        ),
        const Divider(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            DeletePostWidget(postId: postEntitie.id!),
            UpdatePostButton(postEntitie: postEntitie)
          ],
        )
      ],
    );
  }
}
