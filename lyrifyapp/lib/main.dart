import 'package:flutter/material.dart';
import 'package:lyrifyapp/pages/authscreen.dart';
import 'package:lyrifyapp/pages/homescreen.dart';
import 'package:lyrifyapp/pages/authscreen.dart';
import 'package:lyrifyapp/pages/loadingscreen.dart';

void main() {
  runApp(const LyrifyApp());
}

class LyrifyApp extends StatelessWidget {
  const LyrifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoadingScreen(),
    );
  }
}
