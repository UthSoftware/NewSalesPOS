import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String> items;
  final String selectedValue;
  final ValueChanged<String?> onChanged;
  final double? width;
  final double height;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? iconColor;
  final double? fontSize;
  final double borderRadius;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;

  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.width,
    this.height = 35,
    this.borderColor,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.fontSize = 12,
    this.borderRadius = 4,
    this.fontWeight,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor ?? Colors.grey.shade400, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          icon: Icon(Icons.arrow_drop_down, color: iconColor ?? Colors.black54),
          isExpanded: true,
          dropdownColor: backgroundColor ?? Colors.white,
          style: GoogleFonts.openSans(
            fontSize: fontSize,
            color: textColor ?? Colors.black87,
            fontWeight: fontWeight ?? FontWeight.w500,
          ),
          onChanged: onChanged,
          items:
              items.map((String item) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
        ),
      ),
    );
  }
}
