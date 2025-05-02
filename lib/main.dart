import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shome/screens/homePage.dart';
import 'package:shome/screens/loading_screen.dart';
import 'package:shome/screens/login.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Home',
      // home: const LoadingScreen(),
      home: const homePage(),
    );
  }
}
