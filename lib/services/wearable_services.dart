// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class WearOSScreen extends StatelessWidget {
  final WearOSCommunication _wearOSCommunication = WearOSCommunication();

  WearOSScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wear OS Communication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _wearOSCommunication.sendDataToWatch("Hello Wear OS");
              },
              child: const Text('Send Data to Watch'),
            ),
            ElevatedButton(
              onPressed: () {
                _wearOSCommunication.setupMessageListener();
              },
              child: const Text('Setup Message Listener'),
            ),
          ],
        ),
      ),
    );
  }
}

class WearOSCommunication {
  static const platform = MethodChannel('com.example.wearos');

  Future<void> sendDataToWatch(String data) async {
    try {
      await platform.invokeMethod('sendData', {'data': data});
    } on PlatformException catch (e) {
      print("Failed to send data: '${e.message}'.");
    }
  }

  Future<void> setupMessageListener() async {
    platform.setMethodCallHandler((call) async {
      if (call.method == 'onMessageReceived') {
        final String receivedData = call.arguments;
        // Handle the received data here
        print("Received data: $receivedData");
      }
    });
  }
}
