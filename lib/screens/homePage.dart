import 'package:flutter/material.dart';

class homePage extends StatelessWidget {
  const homePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: ,
        title: const Text(
          'alvvv',
          textAlign: TextAlign.center,
          style: TextStyle(color: Color.fromARGB(107, 11, 102, 230), fontSize: 30),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.hub),
            label: 'Control',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics),
            label: 'Data',
          ),
          NavigationDestination(
            icon: Icon(Icons.exit_to_app),
            label: 'exit',
          ), //
        ],
      ),
      body: Container(),
    );
  }
}
