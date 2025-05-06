import 'package:flutter/material.dart';

class ControlScreen extends StatelessWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Control')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Card(
              color: Colors.cyan.withOpacity(0.5),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              child: SizedBox(
                width: 100,
                height: 100,
                child: Center(child: Text('Tarjeta 1')),
              ),
            ),
            Card(
              color: Colors.blue.withOpacity(0.5),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              child: SizedBox(
                width: 100,
                height: 100,
                child: Center(child: Text('Tarjeta 2')),
              ),
            ),
            Card(
              color: Colors.green.withOpacity(0.5),
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              child: SizedBox(
                width: 100,
                height: 100,
                child: Center(child: Text('Tarjeta 3')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
