import 'package:flutter/material.dart';
import 'package:soft_sales/screens/sales/order_summary_panel_widgets/order_summary_panel_ui.dart';
import 'package:soft_sales/screens/sales/product_panel_widgets/product_panel_ui.dart';

class SalesScreen extends StatefulWidget {
  final VoidCallback onMenuPressed;

  const SalesScreen({super.key, required this.onMenuPressed});

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
          // hi
          Expanded(flex: 6, child: ProductPanelUi(onMenuPressed: widget.onMenuPressed)),
          Expanded(flex: 4, child: SalesOrderSummary()),
        ],
      ),
    );
  }
}
