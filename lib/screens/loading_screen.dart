import 'dart:async';
import 'package:flutter/material.dart';
import 'login.dart'; // Assuming login.dart is in the same directory

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 0), () {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => const Login()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.4,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),

          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/esta.jpg',
                  width: 300, // Adjust the width as needed
                  height: 300, // Adjust the height as needed
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 10),
                const CircularProgressIndicator(),
                const Text('Loading...'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
