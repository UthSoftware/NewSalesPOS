import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:soft_sales/screens/layout_handler/layout_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'SALES POS',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [GetPage(name: '/', page: () => LayoutHandler())],
      // home:
      //     LayoutHandler(), //DineInTablesScreen(), // SalesScreen(), // SalesLoginScreen(),//DashboardScreenSalesUiHandler
    );
  }
}
