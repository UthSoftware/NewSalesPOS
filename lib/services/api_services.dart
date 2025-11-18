// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:soft_sales/widgets/custom_toast.dart';
import 'package:soft_sales/widgets/error_widget.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3500/api';
  // final String baseUrl = 'https://uthmultiposnode.uthsoftware.com/api';

  var conflictMessage;

  /// Handles HTTP response
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        return json.decode(response.body);
      } catch (e) {
        throw Exception('Response parsing error: Expected JSON format');
      }
    } else {
      if (response.statusCode == 409) {
        try {
          var responseBody = json.decode(response.body);
          String errorMessage = responseBody['message'] ?? 'Duplicate Entry';
          conflictMessage = errorMessage;
          // _showToast(errorMessage);
          debugPrint("errorMessage :$errorMessage");
        } catch (e) {
          debugPrint("e :$e");
          _showToast('Error occurred. Please try again.');
        }
      }
      throw Exception('Request failed: ${response.statusCode} - ${response.reasonPhrase}');
    }
  }

  /// Handles API errors
  dynamic _handleError(dynamic error, String requestType) {
    String errorMessage = 'An error occurred';
    if (error is SocketException) {
      errorMessage = 'Network connection error. Please check your internet.';
    } else if (error is HttpException) {
      errorMessage = 'Server error. Please try again later.';
    } else if (error is FormatException) {
      errorMessage = 'Invalid response format.';
    } else {
      errorMessage = error.toString();
    }

    if (errorMessage.contains('409 - Conflict')) {
      // errorMessage = 'Duplicate entry detected. Please insert correct values.';
      errorMessage = conflictMessage;
    }

    if (!(Get.isDialogOpen ?? false)) {
      Get.dialog(ErrorDialogWidget(errorMessage: errorMessage), barrierColor: Colors.transparent);
    }

    debugPrint('$requestType Error: $errorMessage');
    return (errorMessage);
  }

  /// Helper function to show toast messages
  void _showToast(String message) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ToastService().showErrorToast(message);
    });
  }

  /// Generic HTTP GET request
  Future<dynamic> get(String endpoint) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      debugPrint(url.toString());
      final response = await http.get(url);
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e, 'GET');
    }
  }

  /// Generic HTTP POST request
  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final jsonBodyReq = json.encode(data);
      debugPrint('Url : ${url.toString()}');
      debugPrint('Json Body : ${jsonBodyReq.toString()}');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonBodyReq,
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e, 'POST');
    }
  }

  /// Generic HTTP PUT request
  Future<dynamic> put(String endpoint, dynamic data) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e, 'PUT');
    }
  }

  /// Generic HTTP DELETE request
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$endpoint'));
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e, 'DELETE');
    }
  }

  /// Multipart POST request for file upload
  Future<dynamic> multipartPost(
    String endpoint,
    Map<String, String> fields, // Ensure this is a Map<String, String>
    File? file,
    String fieldName,
  ) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/$endpoint'));

      // Add text fields
      request.fields.addAll(fields);

      // Add file if provided
      if (file != null && await file.exists()) {
        request.files.add(await http.MultipartFile.fromPath(fieldName, file.path));
      }

      // Send the request and process the response
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return _handleResponse(response);
    } catch (e) {
      throw _handleError(e, 'Multipart POST');
    }
  }
}
