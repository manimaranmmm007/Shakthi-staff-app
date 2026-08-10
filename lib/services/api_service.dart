import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "https://shakthiconsultancy.in/api";
  
  static Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {'username': username, 'password': password},
    );
    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> getDashboard(String staffId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/dashboard.php?staff_id=$staffId'),
    );
    return json.decode(response.body);
  }
}
