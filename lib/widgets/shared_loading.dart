import 'package:flutter/material.dart';
import 'package:workshop_flutter_firebases/theme/colors.dart';

class SharedLoading extends StatelessWidget {
  const SharedLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        color: AppColors.feldgrau,
      ),
    );
  }
}
