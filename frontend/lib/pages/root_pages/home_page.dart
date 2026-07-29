import 'package:flutter/material.dart';
import 'package:frontend/themes/text_styles.dart';

class HomePage extends StatefulWidget {
  final ScrollController controller;
  const HomePage({Key? key, required this.controller}) : super(key: key);

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  // const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [Text('Hem', style: AppTextStyles.pageTitle)]),
      ),
      body: SingleChildScrollView(
        controller: widget.controller,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 200, bottom: 16),
              child: Text(''),
            ),
          ],
        ),
      ),
    );
  }
}
