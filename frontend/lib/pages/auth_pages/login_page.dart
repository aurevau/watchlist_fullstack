import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/input_text_field.dart';
import 'package:frontend/components/link_footer.dart';
import 'package:frontend/pages/auth_pages/register_page.dart';
import 'package:frontend/pages/root_pages/home_page.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/themes/colors.dart';
import 'package:frontend/themes/text_styles.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Välkommen tillbaka", style: AppTextStyles.pageTitle),
            SizedBox(height: 40),

            // Email input
            InputTextField(
              hintText: "Email",
              isPassword: false,
              controller: _emailController,
            ),

            SizedBox(height: 16),

            // Password input
            InputTextField(
              hintText: "Lösenord",
              isPassword: true,
              controller: _passwordController,
            ),

            SizedBox(height: 24),

            if (authProvider.errorMessage != null)
              Text(authProvider.errorMessage!, style: AppTextStyles.errorText),

            SizedBox(height: 16),

            authProvider.isLoading
                ? const CircularProgressIndicator()
                :
                  // Sign in button
                  CustomButton(
                    buttonText: "LOGGA IN",
                    onPressedButton: () {
                      _handleLogin();
                    },
                  ),

            SizedBox(height: 16),

            // Not a member registration
            LinkFooter(
              firstLineText: "Inte medlem? ",
              secondLineText: "Registrera nu",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => RegisterPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
