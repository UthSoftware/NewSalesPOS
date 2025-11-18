// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorDialogWidget extends StatefulWidget {
  final String errorMessage;

  const ErrorDialogWidget({super.key, required this.errorMessage});

  @override
  _ErrorDialogWidgetState createState() => _ErrorDialogWidgetState();
}

class _ErrorDialogWidgetState extends State<ErrorDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red),
          SizedBox(width: 8),
          Text('Error', style: TextStyle(color: Colors.red)),
        ],
      ),
      content: Text(widget.errorMessage, style: const TextStyle(fontSize: 16)),
      actions: [
        TextButton(
          onPressed: () {
            Get.back(); // Close the dialog
          },
          child: const Text('OK', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
