import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:http/http.dart' as http;

class ControlScreen extends StatefulWidget {
  @override
  _ControlScreenState createState() => _ControlScreenState();
}

class _ControlScreenState extends State<ControlScreen> {
  final String baseUrl =
      'http://your_arduino_ip'; // Replace with your Arduino's IP address
  final String cameraUrl =
      'http://your_arduino_ip:81/stream'; // Replace with your camera stream URL

  Future<void> _sendCommand(String command) async {
    final response = await http.get(Uri.parse('$baseUrl/$command'));
    if (response.statusCode == 200) {
      print('Command sent successfully');
    } else {
      print('Failed to send command');
    }
  }

  void _handleVerticalJoystick(StickDragDetails details) {
    if (details.y > 0.5) {
      _sendCommand('up');
    } else if (details.y < -0.5) {
      _sendCommand('down');
    }
  }

  void _handleAllDirectionJoystick(StickDragDetails details) {
    if (details.x > 0.5) {
      _sendCommand('right');
    } else if (details.x < -0.5) {
      _sendCommand('left');
    }
    if (details.y > 0.5) {
      _sendCommand('forward');
    } else if (details.y < -0.5) {
      _sendCommand('backward');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drone Control')),
      body: Column(
        children: [
          Expanded(
            child: cameraUrl != null
                ? Image.network(cameraUrl, fit: BoxFit.cover)
                : Center(child: CircularProgressIndicator()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Joystick(
                mode: JoystickMode.vertical,
                listener: (details) {
                  _handleVerticalJoystick(details);
                },
              ),
              Joystick(
                mode: JoystickMode.all,
                listener: (details) {
                  _handleAllDirectionJoystick(details);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
