import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workshop_flutter_firebases/theme/colors.dart';

class SharedTextFormField extends StatelessWidget {
  final String title;
  final TextEditingController Controller;
  final String labelText;
  final bool readOnly;
  final VoidCallback? onTap;
  final bool obsecureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;

  const SharedTextFormField({
    super.key,
    required this.title,
    required this.Controller,
    required this.labelText,
    this.readOnly = false,
    this.onTap,
    this.obsecureText = false,
    this.validator,
    this.suffixIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Text(title),
        ),
        TextFormField(
          style: GoogleFonts.montserrat(),
          focusNode: AppColors.black_olive,
          obscureText: obsecureText,
          controller: Controller,
          readOnly: readOnly,
          onTap: onTap,
          validator: validator,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: GoogleFonts.montserrat(fontSize: 12),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.black_olive),
            ),
            focusColor: AppColors.black_olive,
          ),
        ),
      ],
    );
  }
}
