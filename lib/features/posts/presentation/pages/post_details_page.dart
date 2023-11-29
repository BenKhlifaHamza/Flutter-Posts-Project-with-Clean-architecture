import '../../domaine/entities/post_entitie.dart';
import '../widgets/post_details_widgets/post_details_widget.dart';
import 'package:flutter/material.dart';

class PostDetailsPage extends StatelessWidget {
  final PostEntitie postEntitie;
  const PostDetailsPage({super.key, required this.postEntitie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
      title: const Text("Post Details"),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: PostDetailsWidget(postEntitie: postEntitie),
    );
  }
}
