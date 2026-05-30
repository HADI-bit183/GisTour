import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const DesaWisataApp());
}

class DesaWisataApp extends StatelessWidget {
  const DesaWisataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GisTour',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2D6A4F),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'Georgia',
      ),
      home: const LoginPage(),
    );
  }
}
