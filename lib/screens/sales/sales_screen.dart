import 'package:flutter/material.dart';
import 'package:soft_sales/screens/sales/order_summary_panel_widgets/order_summary_panel_ui.dart';
import 'package:soft_sales/screens/sales/product_panel_widgets/product_panel_ui.dart';

class SalesScreen extends StatelessWidget {
  final VoidCallback? onMenuPressed;

  const SalesScreen({super.key, this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
