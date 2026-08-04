import 'package:flutter/material.dart';
import 'package:frontend/pages/auth_pages/auth_wrapper.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/providers/movie_provider.dart';
import 'package:frontend/providers/watchlist_provider.dart';
import 'package:frontend/themes/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => WatchlistProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme.lightTheme, home: AuthWrapper());
  }
}
