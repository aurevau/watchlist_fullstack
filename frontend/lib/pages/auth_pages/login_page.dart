import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/input_text_field.dart';
import 'package:frontend/components/link_footer.dart';
import 'package:frontend/pages/auth_pages/register_page.dart';
import 'package:frontend/themes/colors.dart';
import 'package:frontend/themes/text_styles.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Välkommen tillbaka", style: AppTextStyles.pageTitle),
            SizedBox(height: 40),

            // Email input
            InputTextField(hintText: "Email", isPassword: false),

            SizedBox(height: 16),

            // Password input
            InputTextField(hintText: "Lösenord", isPassword: true),

            SizedBox(height: 24),

            // Sign in button
            CustomButton(buttonText: "LOGGA IN", onPressedButton: () {}),

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
