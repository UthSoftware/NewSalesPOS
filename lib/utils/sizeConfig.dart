// ignore_for_file: file_names

import 'dart:math';

import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData = const MediaQueryData();
  static double screenWidth = 0.0;
  static double screenHeight = 0.0;
  static double defaultSize = 0.0;
  static Orientation orientation = Orientation.portrait;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
  }
}

// Get the proportionate height as per screen size
double getProportionateScreenHeight(double inputHeight) {
  double screenHeight = SizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getProportionateScreenWidth(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

double getProportionateScreenWidthIncreace1(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  // Adjust the exponent (>1 for faster scaling)
  double exponent = 1.2; // Experiment with values (1.1, 1.3, etc.)
  return inputWidth * pow(screenWidth / 375.0, exponent);
}

double getProportionateScreenWidthIncreace2(double inputWidth) {
  double screenWidth = SizeConfig.screenWidth;
  if (screenWidth < 600) return inputWidth * 1.0;
  if (screenWidth < 900) return inputWidth * 1.5;
  if (screenWidth < 1200) return inputWidth * 2.0;
  return inputWidth * 2.5; // Largest screens
}

double getFindStringWidthWithContext(
  String str,
  double fontSize,
  BuildContext context, {
  FontWeight? fontWeight,
}) {
  final defaultStyle = DefaultTextStyle.of(context).style;

  final TextPainter textPainter = TextPainter(
    text: TextSpan(
      text: str,
      style: defaultStyle.copyWith(fontSize: fontSize, fontWeight: fontWeight),
    ),
    textDirection: TextDirection.ltr,
  )..layout();

  return textPainter.width + 20;
}

// Get Header Font Name
double getHeaderFontSize() {
  return getProportionateScreenHeight(20);
}
