import 'package:flutter/material.dart';
import 'package:frontend/pages/root_pages/settings_page.dart';
import 'package:frontend/themes/text_styles.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
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
      body: Center(child: Text("")),
    );
  }
}
