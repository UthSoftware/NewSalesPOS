import 'package:flutter/material.dart';

class CustomerReport extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const CustomerReport({super.key, required this.onMenuPressed});

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
