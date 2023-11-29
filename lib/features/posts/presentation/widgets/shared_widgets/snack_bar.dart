import '../../../../../core/constantes/app_colors.dart';
import 'package:flutter/material.dart';

class SnackBarWidget {
  static void showSuccessSnackBar(
      {required String msgSuc, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        content: Text(
          msgSuc,
          style: const TextStyle(color: AppColors.whiteColor),
        )));
  }

  static void showErrorSnackBar(
      {required String msgErr, required BuildContext context}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          msgErr,
          style: const TextStyle(color: AppColors.whiteColor),
        )));
  }
}
