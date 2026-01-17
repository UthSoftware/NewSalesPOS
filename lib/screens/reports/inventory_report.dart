import 'package:flutter/material.dart';

class InventoryReport extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const InventoryReport({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(icon: Icon(Icons.menu), onPressed: onMenuPressed),
        Expanded(child: Center(child: Text('Sales Report Screen'))),
      ],
    );
  }
}
