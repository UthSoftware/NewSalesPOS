import 'package:flutter/material.dart';

class OrderListScreen extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const OrderListScreen({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(icon: Icon(Icons.menu), onPressed: onMenuPressed),
        Expanded(child: Center(child: Text('Order List Screen'))),
      ],
    );
  }
}
