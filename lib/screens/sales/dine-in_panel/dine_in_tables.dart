import 'package:flutter/material.dart';
import 'package:soft_sales/screens/sales/dine-in_panel/table_filters_header.dart';
import 'package:soft_sales/screens/sales/dine-in_panel/tables_selection.dart';
import 'package:soft_sales/utils/sizeConfig.dart';

class DineInTablesScreen extends StatefulWidget {
  const DineInTablesScreen({super.key});

  @override
  State<DineInTablesScreen> createState() => _DineInTablesScreenState();
}

class _DineInTablesScreenState extends State<DineInTablesScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(getProportionateScreenWidth(4)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [TableFiltersHeader(), TablesSelection()],
        ),
      ),
    );
  }
}

class TableStatusModel {
  final String statusName;
  final Color? unselectedColor;
  final Color? unselectedBackgroundColor;
  final Color? selectedColor;
  final Color? selectedBackgroundColor;

  const TableStatusModel({
    required this.statusName,
    this.unselectedColor,
    this.unselectedBackgroundColor,
    this.selectedColor,
    this.selectedBackgroundColor,
  });
}
