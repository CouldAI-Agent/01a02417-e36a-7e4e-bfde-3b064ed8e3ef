import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'server_selection_screen.dart';

void main() {
  runApp(const VpnYasaApp());
}

class VpnYasaApp extends StatelessWidget {
  const VpnYasaApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VPN Yasa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0D1B2A), // Dark blue background
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/servers': (context) => const ServerSelectionScreen(),
      },
    );
  }
}
