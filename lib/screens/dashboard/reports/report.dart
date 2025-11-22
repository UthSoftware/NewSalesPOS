import 'package:flutter/material.dart';

class SalesReportExample extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const SalesReportExample({super.key, required this.onMenuPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(icon: Icon(Icons.menu), onPressed: onMenuPressed),
        Expanded(child: Center(child: Text('Settings Screen'))),
      ],
    );
  }
}
