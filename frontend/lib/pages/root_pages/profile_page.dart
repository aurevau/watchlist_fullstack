import 'package:flutter/material.dart';
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
            Icon(Icons.settings, size: 30),
          ],
        ),
      ),
      body: Center(child: Text("")),
    );
  }
}
