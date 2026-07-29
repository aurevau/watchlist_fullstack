import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/input_text_field.dart';
import 'package:frontend/components/link_footer.dart';
import 'package:frontend/pages/auth_pages/login_page.dart';
import 'package:frontend/pages/navigation/main_navigation.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/themes/text_styles.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegistration() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.register(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainNavigation()),
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
            Text("Skapa konto", style: AppTextStyles.pageTitle),

            SizedBox(height: 40),

            InputTextField(
              hintText: "Namn",
              isPassword: false,
              controller: _nameController,
            ),

            SizedBox(height: 16),

            InputTextField(
              hintText: "Email",
              isPassword: false,
              controller: _emailController,
            ),

            SizedBox(height: 16),

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
                : CustomButton(
                    buttonText: "SKAPA KONTO",
                    onPressedButton: () {
                      _handleRegistration();
                    },
                  ),

            SizedBox(height: 16),

            LinkFooter(
              firstLineText: "Redan medlem? ",
              secondLineText: "Logga in",
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
