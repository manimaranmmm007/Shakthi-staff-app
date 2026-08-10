import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final userController = TextEditingController();
  final passController = TextEditingController();
  bool loading = false;

  void login() async {
    setState(()=> loading = true);
    var result = await ApiService.login(userController.text, passController.text);
    setState(()=> loading = false);
    if(result['status'] == 'success'){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen(data: result)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result['message'] ?? 'Login Failed')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("SHAKTHI STAFF LOGIN")),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          TextField(controller: userController, decoration: InputDecoration(labelText: "Username")),
          TextField(controller: passController, decoration: InputDecoration(labelText: "Password"), obscureText: true),
          SizedBox(height: 20),
          loading ? CircularProgressIndicator() : ElevatedButton(onPressed: login, child: Text("Login"))
        ]),
      ),
    );
  }
}
