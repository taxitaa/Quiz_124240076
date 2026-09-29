import 'package:flutter/material.dart';
import 'pages/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF800020)),
      ),
      home: const LoginPage(),
      routes: {'/login': (_) => const LoginPage()},
    );
  }
}
