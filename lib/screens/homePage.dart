import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 212, 35, 0),
        title: const Text(
          'alvvv',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 35),
        ),
      ),
      body: Container(),
    );
  }
}
