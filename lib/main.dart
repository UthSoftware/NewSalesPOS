import 'package:flutter/material.dart';
import 'package:soft_sales/screens/dashboard/dashboard_screen_sales_ui_handler.dart';
import 'package:soft_sales/screens/sales/sales_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SALES POS',
      debugShowCheckedModeBanner: false,
      home:
          DashboardScreenSalesUiHandler(), //DineInTablesScreen(), // SalesScreen(), // SalesLoginScreen(),//DashboardScreenSalesUiHandler
    );
  }
}
