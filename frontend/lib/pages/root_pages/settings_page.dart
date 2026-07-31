import 'package:flutter/material.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/pages/auth_pages/login_page.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Inställningar')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomButton(
                buttonText: 'LOGGA UT',
                onPressedButton: () async {
                  print('Log out button pressed');
                  await context.read<AuthProvider>().logout();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
