import 'package:flutter/material.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/screens/sales/order_summary_panel_widgets/filter_and_add_item.dart';
import 'package:soft_sales/screens/sales/order_summary_panel_widgets/order_summary_body.dart';
import 'package:soft_sales/screens/sales/order_summary_panel_widgets/order_summary_footer.dart';
import 'package:soft_sales/screens/sales/order_summary_panel_widgets/order_summary_header.dart';

// ignore: must_be_immutable
class SalesOrderSummary extends StatelessWidget with MyColors {
  SalesOrderSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(left: BorderSide(color: MyColors.borderColor)),
            ),
            child: Column(
              children: [SalesOrderSummaryHeader(), FilterAndAddItem(), OrderSummaryBody()],
            ),
          ),
        ),
        OrderSummaryFooter(),
      ],
    );
  }
}
