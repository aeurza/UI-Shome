import 'package:flutter/material.dart';
import 'package:shome/screens/homePage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home',
      // home: const Login(),
      home: const homePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text(
          'Smart Home',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
      ),
      body: Container(),
    );
  }
}
