import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'splash_screen.dart';
import 'wifi_connection_screen.dart';
import 'control_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drone Controller',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/wifi': (context) => WiFiConnectionScreen(),
        '/control': (context) => ControlScreen(),
      },
    );
  }
}
