import 'package:flutter/material.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  String _selectedCard = 'Ninguna tarjeta seleccionada';

  void _updateSelectedCard(int cardNum) {
    setState(() {
      _selectedCard = 'Tarjeta $cardNum seleccionada';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Card(
              margin: const EdgeInsets.all(20.0),
              child: Container(
                width: double.infinity,
                height: 300,
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    _selectedCard,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _updateSelectedCard(1);
                  },
                  child: Card(
                    color: Colors.cyan.withOpacity(0.5),
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: const SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(child: Text('Tarjeta 1')),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _updateSelectedCard(2);
                  },
                  child: Card(
                    color: Colors.blue.withOpacity(0.5),
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: const SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(child: Text('Tarjeta 2')),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    _updateSelectedCard(3);
                  },
                  child: Card(
                    color: Colors.green.withOpacity(0.5),
                    surfaceTintColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    child: const SizedBox(
                      width: 100,
                      height: 100,
                      child: Center(child: Text('Tarjeta 3')),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
