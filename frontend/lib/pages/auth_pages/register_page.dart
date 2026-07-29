import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/input_text_field.dart';
import 'package:frontend/components/link_footer.dart';
import 'package:frontend/pages/auth_pages/login_page.dart';
import 'package:frontend/themes/text_styles.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Skapa konto", style: AppTextStyles.pageTitle),

            SizedBox(height: 40),

            InputTextField(hintText: "Namn", isPassword: false),

            SizedBox(height: 16),

            InputTextField(hintText: "Email", isPassword: false),

            SizedBox(height: 16),

            InputTextField(hintText: "Lösenord", isPassword: true),

            SizedBox(height: 24),

            CustomButton(buttonText: "SKAPA KONTO", onPressedButton: () {}),

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
