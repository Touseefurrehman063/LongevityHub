import 'dart:developer';

import 'package:get/get.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BleController extends GetxController implements GetxService {
  RxMap<String, BluetoothDevice> connectedDevices =
      <String, BluetoothDevice>{}.obs;

  static BleController get i => Get.find<BleController>();

  void addDevice(BluetoothDevice device) {
    connectedDevices[device.remoteId.str] = device;
  }

  void removeDevice(BluetoothDevice device) {
    connectedDevices.remove(device.remoteId.str);
  }

  void setDeviceConnectionState(BluetoothDevice device, bool isConnected) {
    if (isConnected) {
      addDevice(device);
    } else {
      removeDevice(device);
    }
  }

  // Store the heart rate value
  final RxInt heartRate = 0.obs;

  // Method to update heart rate
  void updateHeartRate(int value) {
    heartRate.value = value;
    log('Heart rate updated: $value');
  }

  @override
  void onInit() {
    super.onInit();
    _restoreConnectedDevices();
  }

  void _restoreConnectedDevices() async {
    var devices = FlutterBluePlus.connectedDevices;
    for (var device in devices) {
      addDevice(device);
    }
  }
}
