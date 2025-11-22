import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback onMenuPressed;

  const SettingsScreen({super.key, required this.onMenuPressed});

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
