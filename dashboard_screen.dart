
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';
import 'dart:convert';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int leadsCount = 0;
  int customersCount = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    try {
      final leadsRes = await ApiService.getLeads();
      final custRes = await ApiService.getCustomers();
      if (leadsRes.statusCode == 200) {
        final data = jsonDecode(leadsRes.body);
        leadsCount = data is List ? data.length : (data['total'] ?? 0);
      }
      if (custRes.statusCode == 200) {
        final data = jsonDecode(custRes.body);
        customersCount = data is List ? data.length : (data['total'] ?? 0);
      }
    } catch (e) {
      print(e);
    }
    setState(() => loading = false);
  }

  logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shakthi Dashboard"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [IconButton(onPressed: logout, icon: Icon(Icons.logout))],
      ),
      body: loading ? Center(child: CircularProgressIndicator()) : Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _card("Total Leads", "$leadsCount", Icons.leaderboard, Colors.orange),
            _card("Customers", "$customersCount", Icons.people, Colors.green),
            _card("Bank Ops", "View", Icons.account_balance, Colors.blue),
            _card("Cold Pool", "View", Icons.ac_unit, Colors.purple),
            _card("Staff", "View", Icons.badge, Colors.teal),
            _card("Reports", "View", Icons.bar_chart, Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _card(String title, String count, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 10),
            Text(count, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }
}
