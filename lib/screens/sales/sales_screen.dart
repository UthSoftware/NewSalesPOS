import 'package:flutter/material.dart';
import 'package:soft_sales/screens/sales/order_summary_panel_widgets/order_summary_panel_ui.dart';
import 'package:soft_sales/screens/sales/product_panel_widgets/product_panel_ui.dart';

class SalesScreen extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const SalesScreen({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(flex: 3, child: ProductPanelUi(onMenuPressed: onMenuPressed)),
              Expanded(flex: 2, child: SalesOrderSummary()),
            ],
          ),
        ),
      ],
=======
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(flex: 6, child: ProductPanelUi()),
          Expanded(flex: 4, child: SalesOrderSummary()),
        ],
      ),
>>>>>>> 5efbc69a55a6e463e28ba0dfe656b7e4a5264603
    );
  }
}
