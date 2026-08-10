
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = "https://shakthi-loan-ops.preview.emergentagent.com/api";

  static Future<Map<String, String>> _headers() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
  }

  static Future<http.Response> login(String phone, String password) async {
    return await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"phone": phone, "password": password, "otp": "123456"}),
    );
  }

  static Future<http.Response> getLeads() async {
    return await http.get(Uri.parse('$baseUrl/leads'), headers: await _headers());
  }

  static Future<http.Response> getCustomers() async {
    return await http.get(Uri.parse('$baseUrl/customer'), headers: await _headers());
  }

  static Future<http.Response> getBankOps() async {
    return await http.get(Uri.parse('$baseUrl/bank-ops'), headers: await _headers());
  }

  static Future<http.Response> getStaff() async {
    return await http.get(Uri.parse('$baseUrl/staff'), headers: await _headers());
  }

  static Future<http.Response> getPool() async {
    return await http.get(Uri.parse('$baseUrl/pool'), headers: await _headers());
  }
}
