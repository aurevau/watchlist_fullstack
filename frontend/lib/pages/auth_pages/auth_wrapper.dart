import 'package:flutter/material.dart';
import 'package:frontend/pages/auth_pages/login_page.dart';
import 'package:frontend/pages/navigation/main_navigation.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/themes/text_styles.dart';
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
    await Future.wait([
      Future.delayed(const Duration(seconds: 2)),
      authProvider.tryAutoLogin(),
    ]);

    setState(() {
      _checkingAuth = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingAuth) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.network(
              //   "https://user-images.githubusercontent.com/6876788/96633009-d1818000-1318-11eb-9f1d-7f914f4ccb16.gif",
              // ),
              Text("Loading", style: AppTextStyles.sectionTitle),
              const SizedBox(height: 32),

              CircularProgressIndicator(),
            ],
          ),
        ),
      );
    }

    final authProvider = Provider.of<AuthProvider>(context);
    return authProvider.isLoggedIn ? const MainNavigation() : const LoginPage();
  }
}
