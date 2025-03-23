import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workshop_flutter_firebases/utils/constants.dart';
import 'package:workshop_flutter_firebases/utils/shared_functions.dart';

class SharedCategoryChips extends StatelessWidget {
  final Function(String) isSelected;
  final Function(bool, String)? onSelected;
  const SharedCategoryChips({
    super.key,
    required this.isSelected,
    this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Wrap(
          spacing: 10,
          children: categories.map((categories) {
            return ChoiceChip(
              color: WidgetStatePropertyAll(
                SharedFunctions().randomColor(),
              ),
              label: Text(
                categories,
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                ),
              ),
              selected: isSelected(categories),
              onSelected: (isSelected) {
                onSelected!(isSelected, categories);
              },
            );
          }).toList()),
    );
  }
}
