import 'package:flutter/material.dart';
import 'package:shome/screens/control.dart';
import 'package:shome/screens/login.dart';
import 'package:shome/screens/data.dart';
import 'dart:async';

class homePage extends StatefulWidget {
  const homePage({super.key});

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 0;
  bool _isDarkMode = false; // Variable para controlar el modo oscuro
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
      // Mostrar el diálogo de confirmación antes de salir
      _showExitConfirmationDialog();
    }
  }

  void _resetExitTap() {
    _exitTapCount = 1;
    _exitTapTimer?.cancel();
  }

  // Método para mostrar el diálogo de confirmación
  void _showExitConfirmationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // No permite cerrar tocando fuera del diálogo
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar salida'),
          content: const Text('¿Estás seguro de que quieres salir?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Cerrar el diálogo
                _resetExitTap();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                );
                _resetExitTap();
              },
              child: const Text('Sí, salir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Quitar la bandera de debug
      theme:
          _isDarkMode ? ThemeData.dark() : ThemeData.light(), // Cambio de tema
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            _pageTitles[_selectedIndex],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 15, 225, 208),
          elevation: 4,
          actions: [
            IconButton(
              icon: Icon(
                _isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode; // Alternar el tema
                });
              },
            ),
          ],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.7,
                child: Image.asset('assets/images/bg1.jpg', fit: BoxFit.cover),
              ),
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
              _handleExitTap();
            } else {
              setState(() {
                _selectedIndex = index;
              });
            }
          },
          destinations: [
            const NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
            const NavigationDestination(
              icon: Icon(Icons.hub),
              label: 'Control',
            ),
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
      ),
    );
  }
}
