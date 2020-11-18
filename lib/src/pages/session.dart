import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session extends StatefulWidget {
  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {
  @override
  void initState() {
    super.initState();
    fetchSession();
  }

  fetchSession() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null)
      Navigator.pushReplacementNamed(context, '/login');
    else
      Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}