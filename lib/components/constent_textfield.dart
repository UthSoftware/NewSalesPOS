import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ConstantTextFields extends StatelessWidget {
  String title;
  String imagePath;
  final double? height;
  final double? imageheight;

  final double? width;
  final double? fontSize;
  final Color? color;
  final Widget? suffixIcon;
  ConstantTextFields({
    super.key,
    required this.title,
    required this.imagePath,
    this.height,
    this.width,
    this.color,
    this.imageheight,
    this.fontSize,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius loginBorderRadius = BorderRadius.circular(4);
    double mediaQuery = MediaQuery.of(context).size.width;
    return Container(
      height: height ?? 55,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(color: Color(0XFFF5F5F5), borderRadius: loginBorderRadius),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 8),
          SvgPicture.asset(imagePath, height: imageheight ?? 25),
          SizedBox(width: mediaQuery >= 800 ? (6 + 6) : (8)),
          Text(
            title,
            style: GoogleFonts.openSans(
              fontSize: fontSize ?? (mediaQuery >= 800 ? 16 : 14), // ✅ custom font size
              fontWeight: FontWeight.w600,
              color: color ?? Color(0XFF1E1E1E),
            ),
          ),
          Spacer(),
          if (suffixIcon != null) suffixIcon!,
        ],
      ),
    );
  }
}
