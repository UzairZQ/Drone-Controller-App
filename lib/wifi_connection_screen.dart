import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_iot/wifi_iot.dart';

class WiFiConnectionScreen extends StatefulWidget {
  @override
  _WiFiConnectionScreenState createState() => _WiFiConnectionScreenState();
}

class _WiFiConnectionScreenState extends State<WiFiConnectionScreen> {
  List<WifiNetwork?> _wifiList = [];

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndScan();
  }

  Future<void> _checkPermissionsAndScan() async {
    if (await Permission.location.request().isGranted) {
      _scanForWiFi();
    } else {
      // Handle permission denied
      print('Location permission denied');
      // Optionally, you can show a dialog or notification to the user explaining why the permission is needed
    }
  }

  Future<void> _scanForWiFi() async {
    try {
      List<WifiNetwork?> wifiList = await WiFiForIoTPlugin.loadWifiList();
      setState(() {
        _wifiList = wifiList;
      });
    } catch (e) {
      print("Error scanning for Wi-Fi networks: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wi-Fi Networks'),
      ),
      body: _wifiList.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _wifiList.length,
              itemBuilder: (context, index) {
                final wifi = _wifiList[index];
                return ListTile(
                  title: Text(wifi?.ssid ?? "Unknown SSID"),
                  subtitle: Text(wifi?.bssid ?? "Unknown BSSID"),
                );
              },
            ),
    );
  }
}
