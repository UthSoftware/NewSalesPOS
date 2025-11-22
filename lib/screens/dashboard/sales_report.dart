import 'package:flutter/material.dart';

class SalesReport extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const SalesReport({super.key, required this.onMenuPressed});

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
