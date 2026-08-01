import 'package:flutter/material.dart';
import 'package:frontend/pages/root_pages/settings_page.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/themes/text_styles.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Profil', style: AppTextStyles.pageTitle),
            IconButton(
              icon: Icon(Icons.settings, size: 30),
              onPressed: () {
                Navigator.of(
                  context,
                  rootNavigator: true,
                ).push(MaterialPageRoute(builder: (_) => const SettingsPage()));
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user?.email ?? 'Ingen email hittad'),
            SizedBox(height: 12),
            Text(user?.name ?? 'Ingen användare hittad'),
          ],
        ),
      ),
    );
  }
}
