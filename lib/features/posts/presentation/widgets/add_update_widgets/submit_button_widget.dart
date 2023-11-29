import 'package:flutter/material.dart';

class SubmitButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdate;
  const SubmitButtonWidget(
      {super.key, required this.onPressed, required this.isUpdate});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(isUpdate ? Icons.edit : Icons.add),
      label: Text(isUpdate ? "Update" : "Add"),
    );
  }
}
