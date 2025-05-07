import 'package:flutter/material.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  final List<bool> _switchValues = List.generate(4, (_) => false);
  final List<bool> _buttonStates = List.generate(6, (_) => false); // 6 botones ahora

  final List<String> _buttonLabels = [
    "Room1",
    "Baño2",
    "Sala",
    "Cocina",
    "Baño de visitas",
    "Deposito", // Nuevo botón
  ];

  final List<String> _switchLabels = [
    "Sensor de temperatura",
    "Sensor de humedad",
    "Sensor PIR",
    "Gas",
  ];

  String _displayMessage = "";
  String _selectedSegment = 'Luces';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Control de Dispositivos")),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.5,
              child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Card(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        _displayMessage.isEmpty
                            ? 'Tarjeta de Display'
                            : _displayMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _selectedSegment == 'Luces'
                      ? _buildButtonsColumn()
                      : _buildSwitchesColumn(),
                ),
                const SizedBox(height: 20),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Luces', label: Text('Luces')),
                    ButtonSegment(value: 'Sensores', label: Text('Sensores')),
                  ],
                  selected: {_selectedSegment},
                  onSelectionChanged: (newSelection) {
                    setState(() {
                      _selectedSegment = newSelection.first;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsColumn() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          _buttonLabels.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      _buttonStates[index] ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _buttonStates[index] = !_buttonStates[index];
                    _displayMessage =
                        'Se ${_buttonStates[index] ? 'encendió' : 'apagó'} la luz de ${_buttonLabels[index]}';
                  });
                },
                icon: Icon(
                  _buttonStates[index]
                      ? Icons.lightbulb
                      : Icons.lightbulb_outline,
                  color: _buttonStates[index] ? Colors.yellow : Colors.white,
                ),
                label: Text(
                  _buttonLabels[index],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchesColumn() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(
          _switchLabels.length,
          (index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              elevation: 5,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(_switchLabels[index]),
                    const SizedBox(width: 10),
                    Switch(
                      value: _switchValues[index],
                      onChanged: (value) {
                        setState(() {
                          _switchValues[index] = value;
                          _displayMessage =
                              '${_switchLabels[index]} ${value ? 'activado' : 'desactivado'}';
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
