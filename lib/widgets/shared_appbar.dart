import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workshop_flutter_firebases/theme/colors.dart';

class SharedAppbar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final String title;
  final List<Widget>? actions;

  const SharedAppbar({
    super.key,
    this.leading,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      foregroundColor: AppColors.quaternary,
      backgroundColor: AppColors.sean_green,
      leading: leading,
      title: Text(title,
          style: GoogleFonts.montserrat(
            color: AppColors.quaternary,
            fontWeight: FontWeight.w500,
          )),
      centerTitle: true,
      actions: actions,
    );
  }

  // Mendefinisikan ukuran preferredSize yang dibutuhkan oleh PreferredSizeWidget
  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
