import 'package:flutter/material.dart';

void main() {
  runApp(const DevolioApp());
}

class DevolioApp extends StatelessWidget {
  const DevolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Devolio Flutter Portfolio',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}