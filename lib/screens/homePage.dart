import 'package:flutter/material.dart';
import 'package:shome/screens/control.dart';
import 'package:shome/screens/login.dart';
import 'dart:async';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 0;
  final List<String> _pageTitles = ["Home", "Control", "Data", "Exit"];

  final List<Widget> _pages = [
    const Center(
      child: Text('Página de Inicio', style: TextStyle(fontSize: 24)),
    ),
    Container(), // Placeholder para Control
    const Center(
      child: Text('Página de Datos', style: TextStyle(fontSize: 24)),
    ),
    Container(), // Placeholder para Exit
  ];

  int _exitTapCount = 0;
  Timer? _exitTapTimer;

  void _handleExitTap() {
    _exitTapCount++;
    _exitTapTimer?.cancel();
    _exitTapTimer = Timer(const Duration(seconds: 2), () {
      _resetExitTap();
    });

    if (_exitTapCount < 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pulsa ${3 - _exitTapCount} vez más para salir'),
          duration: const Duration(seconds: 1),
        ),
      );
    }

    if (_exitTapCount == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
      );
      _resetExitTap();
    }
  }

  void _resetExitTap() {
    _exitTapCount = 0;
    _exitTapTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            _pageTitles[_selectedIndex],
            style: const TextStyle(
              color: Color.fromARGB(107, 11, 102, 230),
              fontSize: 30,
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ControlScreen()),
            );
          } else if (index == 3) {
            // Tap para Exit se maneja por GestureDetector
          } else {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
        destinations: [
          const NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          const NavigationDestination(icon: Icon(Icons.hub), label: 'Control'),
          const NavigationDestination(
            icon: Icon(Icons.analytics),
            label: 'Data',
          ),
          NavigationDestination(
            icon: GestureDetector(
              onTap: _handleExitTap,
              child: const Icon(Icons.exit_to_app),
            ),
            label: 'Exit',
          ),
        ],
      ),
      body: Center(
        child:
            _selectedIndex < _pages.length
                ? _pages[_selectedIndex]
                : Container(),
      ),
    );
  }
}
