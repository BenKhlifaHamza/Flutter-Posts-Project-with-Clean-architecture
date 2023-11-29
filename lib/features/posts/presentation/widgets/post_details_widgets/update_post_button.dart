import '../../../domaine/entities/post_entitie.dart';
import '../../pages/add_update_page.dart';
import 'package:flutter/material.dart';

class UpdatePostButton extends StatelessWidget {
  final PostEntitie postEntitie;
  const UpdatePostButton({super.key, required this.postEntitie});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return AddUpdatePage(
              isUpdate: true,
              postEntitie: postEntitie,
            );
          }));
        },
        icon: const Icon(Icons.edit),
        label: const Text("Edit"));
  }
}
