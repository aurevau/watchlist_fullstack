import 'package:flutter/material.dart';
import 'package:frontend/pages/auth_pages/login_page.dart';
import 'package:frontend/pages/navigation/main_navigation.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _checkingAuth = true;

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    await authProvider.tryAutoLogin();

    setState(() {
      _checkingAuth = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingAuth) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final authProvider = Provider.of<AuthProvider>(context);
    return authProvider.isLoggedIn ? const MainNavigation() : const LoginPage();
  }
}
