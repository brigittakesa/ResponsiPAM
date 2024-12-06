import 'package:flutter/material.dart';
import 'package:responsi_010/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsi PAM E',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 236, 101, 5)),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
