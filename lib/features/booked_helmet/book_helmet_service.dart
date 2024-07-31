import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:helmet/constants/show_snackbar.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookHelmetService {
  final String baseUrl = 'http://10.0.2.2:5500/api';

  final storage = FlutterSecureStorage();

  Future<Map<String, dynamic>> getBookedHelmet(BuildContext context) async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      showSnackBar(
          message: 'Token Missing', context: context, color: Colors.red);
      return {};
    }

    final decodedToken = JwtDecoder.decode(token);
    final userId = decodedToken['id'];
    if (userId == null) {
      showSnackBar(
          message: 'ID Not Found', context: context, color: Colors.red);
      return {};
    }
    final url = Uri.parse('$baseUrl/bookedHelmet/$userId');
    final response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse['message']);
    }
  }

  Future<Map<String, dynamic>> bookHelmet(
      BuildContext context, String bookId) async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      showSnackBar(
          message: 'Token Missing',
          context: context,
          color: const Color.fromARGB(255, 188, 134, 130));
      return {};
    }

    final decodedToken = JwtDecoder.decode(token);
    final userId = decodedToken['id'];
    if (userId == null) {
      showSnackBar(
          message: 'ID Not Found', context: context, color: Colors.red);
      return {};
    }
    final url = Uri.parse('$baseUrl/book/$userId/$bookId');
    final response = await http.post(url);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      showSnackBar(
          message: responseBody['message'] ?? 'Booked Successfully',
          context: context,
          color: Colors.green);
      return responseBody;
    } else if (response.statusCode == 409) {
      showSnackBar(
          message: 'Already Booked', context: context, color: Colors.orange);
      return {};
    } else {
      final errorResponse = json.decode(response.body);
      showSnackBar(
          message: errorResponse['message'] ?? 'Booking Failed',
          context: context,
          color: Colors.red);
      throw Exception(errorResponse['message']);
    }
  }
}
