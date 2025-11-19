import 'package:flutter/material.dart';
import 'package:soft_sales/screens/sales/order_summary_panel_widgets/order_summary_panel_ui.dart';
import 'package:soft_sales/screens/sales/product_panel_widgets/product_panel_ui.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(flex: 3, child: ProductPanelUi()),
          Expanded(flex: 2, child: SalesOrderSummary()),
        ],
      ),
    );
  }
}
