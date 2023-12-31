import 'package:flutter/material.dart';

import '../../../../../core/constantes/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 30,
        width: 30,
        child: CircularProgressIndicator(
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
