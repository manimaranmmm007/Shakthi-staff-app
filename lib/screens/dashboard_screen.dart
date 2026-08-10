import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  const DashboardScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dashboard")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome ${data['username'] ?? ''}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("Staff ID: ${data['staff_id'] ?? ''}"),
            SizedBox(height: 10),
            Text(data.toString()),
          ],
        ),
      ),
    );
  }
}
