import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class ControlScreen extends StatefulWidget {
  const ControlScreen({Key? key}) : super(key: key);

  @override
  State<ControlScreen> createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  final List<bool> _switchValues = List.generate(4, (_) => false);
  final List<bool> _buttonStates = List.generate(6, (_) => false);
  String _displayMessage = "Conectando al broker MQTT...";
  String _selectedSegment = 'Luces';
  bool _mqttConnected = false;

  // Configuración MQTT
  late MqttServerClient _mqttClient;
  final String _mqttBroker = '192.168.1.100'; // Cambiar por tu IP
  final int _mqttPort = 1883;

  // Temas MQTT
  final List<String> _buttonTopics = [
    "casa/habitacion1/luz",
    "casa/bano2/luz",
    "casa/sala/luz",
    "casa/cocina/luz",
    "casa/bano_visitas/luz",
    "casa/deposito/luz",
  ];

  final List<String> _switchTopics = [
    "casa/sensores/temperatura",
    "casa/sensores/humedad",
    "casa/sensores/pir",
    "casa/sensores/gas",
  ];

  final List<String> _buttonLabels = [
    "Habitación 1",
    "Baño 2",
    "Sala",
    "Cocina",
    "Baño de visitas",
    "Depósito",
  ];

  final List<String> _switchLabels = [
    "Sensor de temperatura",
    "Sensor de humedad",
    "Sensor PIR",
    "Sensor de Gas",
  ];

  @override
  void initState() {
    super.initState();
    _initMqttConnection();
  }

  Future<void> _initMqttConnection() async {
    _mqttClient = MqttServerClient(
      _mqttBroker,
      'flutter_client_${DateTime.now().millisecondsSinceEpoch}',
    );
    _mqttClient.port = _mqttPort;
    _mqttClient.keepAlivePeriod = 30;
    _mqttClient.onDisconnected = _onDisconnected;

    final connMessage =
        MqttConnectMessage().withWillQos(MqttQos.atLeastOnce).startClean();

    try {
      await _mqttClient.connect();
      setState(() {
        _mqttConnected = true;
        _displayMessage = "Conectado al broker MQTT";
      });
    } catch (e) {
      setState(() {
        _mqttConnected = false;
        _displayMessage = "Error de conexión: $e";
      });
    }

    if (_mqttConnected) {
      _mqttClient.updates!.listen((
        List<MqttReceivedMessage<MqttMessage>> messages,
      ) {
        final MqttPublishMessage recv =
            messages[0].payload as MqttPublishMessage;
        final payload = MqttPublishPayload.bytesToStringAsString(
          recv.payload.message,
        );
        _handleIncomingMessage(messages[0].topic, payload);
      });
    }
  }

  void _onDisconnected() {
    if (mounted) {
      setState(() {
        _mqttConnected = false;
        _displayMessage = "Desconectado del broker";
      });
    }
  }

  void _handleIncomingMessage(String topic, String payload) {
    print('Mensaje recibido: $topic - $payload');
    // Aquí puedes agregar lógica para actualizar la UI con mensajes entrantes
  }

  void _publishMessage(String topic, String message) {
    if (!_mqttConnected) return;

    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    _mqttClient.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  }

  @override
  void dispose() {
    _mqttClient.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildStatusRow(),
                const SizedBox(height: 20),
                Expanded(
                  child:
                      _selectedSegment == 'Luces'
                          ? _buildButtonsGrid()
                          : _buildSensorsList(),
                ),
                const SizedBox(height: 20),
                _buildSegmentControl(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.computer, color: Theme.of(context).primaryColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _displayMessage,
                      style: const TextStyle(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: _mqttConnected ? Colors.green : Colors.red,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonsGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemCount: _buttonLabels.length,
      itemBuilder:
          (context, index) => ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: _buttonStates[index] ? Colors.green : null,
              foregroundColor: _buttonStates[index] ? Colors.white : null,
            ),
            onPressed: () => _handleButtonPress(index),
            icon: Icon(
              _buttonStates[index] ? Icons.lightbulb : Icons.lightbulb_outline,
              color: _buttonStates[index] ? Colors.yellow : null,
            ),
            label: Text(_buttonLabels[index]),
          ),
    );
  }

  void _handleButtonPress(int index) {
    setState(() {
      _buttonStates[index] = !_buttonStates[index];
      _displayMessage =
          '${_buttonLabels[index]} ${_buttonStates[index] ? 'ON' : 'OFF'}';
    });
    _publishMessage(_buttonTopics[index], _buttonStates[index] ? 'ON' : 'OFF');
  }

  Widget _buildSensorsList() {
    return ListView.builder(
      itemCount: _switchLabels.length,
      itemBuilder:
          (context, index) => Card(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: SwitchListTile(
              title: Text(_switchLabels[index]),
              value: _switchValues[index],
              onChanged: (value) => _handleSwitchChange(index, value),
            ),
          ),
    );
  }

  void _handleSwitchChange(int index, bool value) {
    setState(() {
      _switchValues[index] = value;
      _displayMessage =
          '${_switchLabels[index]} ${value ? 'ACTIVADO' : 'DESACTIVADO'}';
    });
    _publishMessage(_switchTopics[index], value ? 'ACTIVADO' : 'DESACTIVADO');
  }

  Widget _buildSegmentControl() {
    return SegmentedButton<String>(
      segments: const [
        ButtonSegment(
          value: 'Luces',
          label: Text('Luces'),
          icon: Icon(Icons.lightbulb_outline),
        ),
        ButtonSegment(
          value: 'Sensores',
          label: Text('Sensores'),
          icon: Icon(Icons.sensors),
        ),
      ],
      selected: {_selectedSegment},
      onSelectionChanged: (Set<String> newSelection) {
        setState(() => _selectedSegment = newSelection.first);
      },
      style: SegmentedButton.styleFrom(
        backgroundColor: Colors.grey[200],
        selectedBackgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
