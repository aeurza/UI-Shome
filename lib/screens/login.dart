import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController ipController = TextEditingController();
    String ipAddress = '';

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/esta.jpg'),
            fit: BoxFit.contain,
          ),
        ),
        child: Center(
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
                child: TextField(
                  controller: ipController,
                  decoration: const InputDecoration(
                    hintText: 'Ingresa la ip del dispositivo.',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ipAddress = ipController.text;
                  Navigator.pushReplacementNamed(
                    context,
                    '/main',
                    arguments: ipAddress,
                  );
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
