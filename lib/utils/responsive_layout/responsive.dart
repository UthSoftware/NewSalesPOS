import 'package:flutter/material.dart';

const double kMobileWidth = 600;
const double kTabletWidth = 1100;

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({super.key, required this.mobile, required this.tablet, required this.desktop});

  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < 600;
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 && MediaQuery.of(context).size.width >= 600;
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    debugPrint("size :$size");
    if (size >= 1100) return desktop;
    if (size >= 650) return tablet;
    return mobile;
  }
}
