import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workshop_flutter_firebases/pages/authentication/login/login_page.dart';
import 'package:workshop_flutter_firebases/pages/list_todo_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _startSplashPage();
  }

  Future<void> _startSplashPage() async {
    await Future.delayed(const Duration(seconds: 2));
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');

    if (email != null && email.isNotEmpty) {
      _navigateToList();
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToList() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return const ListTodoPage();
      }),
    );
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return const LoginPage();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(
            'assets/logo.png',
          ),
          width: 100,
        ),
      ),
    );
  }
}
