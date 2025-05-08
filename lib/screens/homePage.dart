import 'package:flutter/material.dart';
import 'package:shome/screens/control.dart';
import 'package:shome/screens/login.dart';
import 'dart:async';
import 'package:shome/screens/data.dart';

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
    const ControlScreen(),
    const DataScreen(),
    Container(), // Placeholder para Exit
  ];

  int _exitTapCount = 1;
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
          duration: const Duration(seconds: 2),
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
    _exitTapCount = 1;
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
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.7,
            child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
          ),
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder:
                  (child, animation) =>
                      FadeTransition(opacity: animation, child: child),
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: const Color.fromARGB(255, 15, 225, 208),
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          if (index == 3) {
            _handleExitTap(); // Llamar a la lógica de salida
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
          const NavigationDestination(
            icon: Icon(Icons.exit_to_app),
            label: 'Exit',
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
