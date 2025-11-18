import 'package:flutter/material.dart';
import 'package:soft_sales/constants/my_colour.dart';
import 'package:soft_sales/screens/sales/product_panel_widgets/filter_header_widget.dart';
import 'package:soft_sales/screens/sales/product_panel_widgets/group_filter_bar.dart';
import 'package:soft_sales/screens/sales/product_panel_widgets/product_menu_ui.dart';
import 'package:soft_sales/screens/sales/product_panel_widgets/sub_filter_tab_bar.dart';
import 'package:soft_sales/screens/sales/product_panel_widgets/sub_group_filter_bar.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class ProductPanelUi extends StatefulWidget with MyColors {
  const ProductPanelUi({super.key});

  @override
  State<ProductPanelUi> createState() => _ProductPanelUiState();
}

class _ProductPanelUiState extends State<ProductPanelUi> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              FilterHeaderWidget(),
              SubFilterTabBar(),
              GroupFilterBar(),
              SubGroupFilterBar(),
            ],
          ),
        ),
        Expanded(child: ResponsiveFoodGrid()),
      ],
    );
  }
}
