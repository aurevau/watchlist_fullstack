import 'package:flutter/material.dart';
import 'package:frontend/themes/text_styles.dart';

class WatchlistPage extends StatefulWidget {
  final ScrollController controller;
  const WatchlistPage({Key? key, required this.controller}) : super(key: key);

  @override
  State<WatchlistPage> createState() => WatchlistPageState();
}

class WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [Text("Watchlist", style: AppTextStyles.pageTitle)],
        ),
      ),
      body: Center(child: Text("")),
    );
  }
}
