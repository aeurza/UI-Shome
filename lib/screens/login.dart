import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para RawKeyEvent
import 'homePage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController ipController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String ipAddress = '';

  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.enter) {
      _performLogin();
    }
  }

  void _performLogin() {
    if (ipController.text == '') {
      ipAddress = ipController.text;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const homePage()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Ingresa la ip Correcta')));
    }
  }

  @override
  void dispose() {
    ipController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.5,
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
                const Text(
                  'Welcome to Smart Home',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 10, 120, 194),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 35),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 10, 120, 194),
                    ),
                  ),
                  child: RawKeyboardListener(
                    focusNode: _focusNode,
                    onKey: _handleKeyEvent,
                    child: TextField(
                      controller: ipController,
                      decoration: const InputDecoration(
                        hintText: 'Ingresa la ip del dispositivo.',
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _performLogin,
                  child: const Text('Ingresar'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
