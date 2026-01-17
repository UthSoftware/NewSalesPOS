import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final String text;
  final Color textColor;

  const CustomContainer({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.text,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      color: color,
      child: Text(text, style: TextStyle(color: textColor, fontSize: 16)),
    );
  }
}
