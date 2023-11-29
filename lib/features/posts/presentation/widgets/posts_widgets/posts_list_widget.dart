import 'package:flutter/material.dart';

import '../../../domaine/entities/post_entitie.dart';
import '../../pages/post_details_page.dart';

class PostsListWidget extends StatelessWidget {
  final List<PostEntitie> postsList;
  const PostsListWidget({super.key, required this.postsList});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: postsList.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(
        thickness: 1,
      ),
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Text(postsList[index].id.toString()),
          title: Text(
            postsList[index].title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(postsList[index].body),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (_) =>
                    PostDetailsPage(postEntitie: postsList[index])));
          },
        );
      },
    );
  }
}
