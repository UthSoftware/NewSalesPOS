import 'package:flutter/material.dart';
import 'package:soft_sales/screens/login/sales_login_screen_desktop.dart';
import 'package:soft_sales/screens/login/sales_login_screen_mobile.dart';
import 'package:soft_sales/utils/responsive_layout/responsive.dart';

class SalesLoginScreen extends StatefulWidget {
  const SalesLoginScreen({super.key});

  @override
  State<SalesLoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SalesLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: SalesLoginScreenMobile(),
      tablet: SalesLoginScreenDesktop(),
      desktop: SalesLoginScreenDesktop(),
    );
  }
}
