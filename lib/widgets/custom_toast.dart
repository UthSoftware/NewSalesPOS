import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

class ToastService {
  static final ToastService _instance = ToastService._internal();

  factory ToastService() {
    return _instance;
  }

  ToastService._internal();

  // Show a custom toast notification
  void showCustomToast({
    required String title,
    required String message,
    Color backgroundColor = Colors.blue,
    Duration duration = const Duration(seconds: 3),
    IconData? icon,
  }) {
    showSimpleNotification(
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      subtitle: Text(message, style: const TextStyle(color: Colors.white)),
      leading: icon != null ? Icon(icon, color: Colors.white) : null,
      background: backgroundColor,
      duration: duration,
      slideDismissDirection: DismissDirection.up,
    );
  }

  // Show a success toast
  void showSuccessToast(String message) {
    showCustomToast(
      title: "Success",
      message: message,
      backgroundColor: Colors.green,
      icon: Icons.check_circle,
    );
  }

  // Show an error toast
  void showErrorToast(String message) {
    showCustomToast(
      title: "Error",
      message: message,
      backgroundColor: Colors.red,
      icon: Icons.error,
    );
  }

  // Show an info toast
  void showInfoToast(String message) {
    showCustomToast(
      title: "Info",
      message: message,
      backgroundColor: Colors.blue,
      icon: Icons.info,
    );
  }

  // Show a warning toast
  void showWarningToast(String message) {
    showCustomToast(
      title: "Warning",
      message: message,
      backgroundColor: Colors.orange,
      icon: Icons.warning,
    );
  }
}
