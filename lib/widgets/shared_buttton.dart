import 'package:flutter/material.dart';
import 'package:workshop_flutter_firebases/theme/colors.dart';

class SharedButtton extends StatelessWidget {
  final Widget title;
  final void Function() onPressed;
  const SharedButtton({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: title,
      style: ElevatedButton.styleFrom(
        elevation: 2,
        backgroundColor: AppColors.tertiary,
        foregroundColor: AppColors.feldgrau,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(double.infinity, 50),
      ),
    );
  }
}
