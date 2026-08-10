
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final phoneCtrl = TextEditingController(text: "9999999999");
  final passCtrl = TextEditingController(text: "admin123");
  bool loading = false;

  doLogin() async {
    setState(() => loading = true);
    try {
      final res = await ApiService.login(phoneCtrl.text, passCtrl.text);
      print(res.body);
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        final token = data['access_token'] ?? data['token'] ?? 'demo-token';
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('user', jsonEncode(data));
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Failed: ${res.body}")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.shield, size: 70, color: Colors.indigo),
                SizedBox(height: 10),
                Text("STAFF LOGIN", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                TextField(controller: phoneCtrl, decoration: InputDecoration(labelText: "Phone", border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone))),
                SizedBox(height: 16),
                TextField(controller: passCtrl, obscureText: true, decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder(), prefixIcon: Icon(Icons.lock))),
                SizedBox(height: 24),
                SizedBox(
                  width: double.infinity, height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, foregroundColor: Colors.white),
                    onPressed: loading ? null : doLogin,
                    child: loading ? CircularProgressIndicator(color: Colors.white) : Text("LOGIN", style: TextStyle(fontSize: 18)),
                  ),
                ),
                SizedBox(height: 12),
                Text("OTP: 123456 (MOCK)", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
