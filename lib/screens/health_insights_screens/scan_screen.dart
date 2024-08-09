import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../data/controller/ble_controller/ble_conroller.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final List<ScanResult> scanResults = [];
  bool isScanning = false;
  BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
  late StreamSubscription<BluetoothAdapterState> _adapterStateSubscription;

  @override
  void initState() {
    super.initState();
    _startScan();
    _requestPermissions();
    _adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      setState(() {
        _adapterState = state;
      });
    });
    // Initialize BleController
    Get.put(BleController());
  }

  @override
  void dispose() {
    _adapterStateSubscription.cancel();
    super.dispose();
  }

  void _requestPermissions() async {
    var status = await [
      Permission.location,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
    ].request();

    if (status[Permission.location]!.isGranted) {
      log('Location permission granted');
    } else {
      log('Location permission denied');
    }
  }

  void _startScan() async {
    setState(() {
      isScanning = true;
      scanResults.clear();
    });

    FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

    FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        scanResults.clear();
        scanResults.addAll(results);
      });

      log('Scan results: ${scanResults.length}');
    }).onDone(() {
      setState(() {
        isScanning = false;
      });
      FlutterBluePlus.stopScan();
    });
  }

  void _toggleScan() {
    if (isScanning) {
      FlutterBluePlus.stopScan();
    } else {
      _startScan();
    }
  }

  void _connectToDevice(BluetoothDevice device) async {
    log("Connecting to ${device.remoteId}");
    try {
      await device.connect();
      BleController.i.setDeviceConnectionState(device, true);

      await Future.delayed(const Duration(seconds: 2));

      if (device.isConnected) {
        List<BluetoothService> services = await device.discoverServices();
        log('Services discovered for ${device.remoteId}:');
        for (var service in services) {
          log('Service UUID: ${service.uuid}');
          log('Characteristics: ${service.characteristics}');
          log('Included Services: ${service.includedServices}');
          log('Service UUID: ${service.serviceUuid}');
        }
      } else {
        log('Device is not connected, cannot discover services.');
      }
    } catch (e) {
      log('Error connecting to device: $e');
    }
  }

  void _disconnectFromDevice(BluetoothDevice device) async {
    log("Disconnecting from ${device.remoteId}");
    try {
      await device.disconnect();
      BleController.i.setDeviceConnectionState(device, false);
    } catch (e) {
      log('Error disconnecting from device: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_adapterState != BluetoothAdapterState.on) {
      return BluetoothOffScreen(adapterState: _adapterState);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan for Devices'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                scanResults.clear();
              });
              _startScan();
            },
          ),
          IconButton(
            icon: Icon(isScanning ? Icons.pause : Icons.play_arrow),
            onPressed: _toggleScan,
          ),
        ],
      ),
      body: Obx(() {
        var connectedDevices = BleController.i.connectedDevices;

        return ListView.builder(
          itemCount: scanResults.length + connectedDevices.length,
          itemBuilder: (context, index) {
            if (index < connectedDevices.length) {
              final deviceEntry = connectedDevices.values.elementAt(index);
              String deviceName = deviceEntry.platformName.isNotEmpty
                  ? deviceEntry.platformName
                  : "Connected Device";
              bool isConnected = BleController.i.connectedDevices
                  .containsKey(deviceEntry.remoteId.str);

              return ListTile(
                title: Text(deviceName),
                subtitle: Text(
                  'ID: ${deviceEntry.remoteId}',
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    if (isConnected) {
                      _disconnectFromDevice(deviceEntry);
                    } else {
                      _connectToDevice(deviceEntry);
                    }
                  },
                  child: Text(isConnected ? 'Disconnect' : 'Connect'),
                ),
              );
            } else {
              final result = scanResults[index - connectedDevices.length];
              String deviceName = result.advertisementData.advName.isNotEmpty
                  ? result.advertisementData.advName
                  : "Unknown Device";
              bool isConnectable = result.advertisementData.connectable;
              bool isConnected = BleController.i.connectedDevices
                  .containsKey(result.device.remoteId.str);

              Widget trailingWidget = isConnectable
                  ? ElevatedButton(
                      onPressed: () {
                        if (isConnected) {
                          _disconnectFromDevice(result.device);
                        } else {
                          _connectToDevice(result.device);
                        }
                      },
                      child: Text(isConnected ? 'Disconnect' : 'Connect'),
                    )
                  : const Text('Not Connectable');

              return ListTile(
                title: Text(deviceName),
                subtitle: Text(
                  'RSSI: ${result.rssi}, ID: ${result.device.remoteId}',
                ),
                trailing: trailingWidget,
              );
            }
          },
        );
      }),
    );
  }
}

class BluetoothOffScreen extends StatelessWidget {
  final BluetoothAdapterState adapterState;

  const BluetoothOffScreen({required this.adapterState, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bluetooth is Off')),
      body: Center(
        child: Text('Bluetooth adapter state: $adapterState'),
      ),
    );
  }
}













// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';

// class ScanScreen extends StatefulWidget {
//   const ScanScreen({super.key});

//   @override
//   State<ScanScreen> createState() => _ScanScreenState();
// }

// class _ScanScreenState extends State<ScanScreen> {
//   final List<ScanResult> scanResults = [];
//   bool isScanning = false;
//   final Map<String, bool> deviceConnectionState = {};
//   final Map<String, BluetoothDevice> connectedDevices = {};
//   BluetoothAdapterState _adapterState = BluetoothAdapterState.unknown;
//   late StreamSubscription<BluetoothAdapterState> _adapterStateSubscription;

//   @override
//   void initState() {
//     super.initState();
//     _startScan();
//     _requestPermissions();
//     _adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) {
//       setState(() {
//         _adapterState = state;
//       });
//     });
//     _restoreConnectedDevices();
//   }

//   @override
//   void dispose() {
//     _adapterStateSubscription.cancel();
//     super.dispose();
//   }

//   void _requestPermissions() async {
//     // Request location and Bluetooth permissions
//     var status = await [
//       Permission.location,
//       Permission.bluetoothScan,
//       Permission.bluetoothConnect,
//     ].request();

//     if (status[Permission.location]!.isGranted) {
//       log('Location permission granted');
//     } else {
//       log('Location permission denied');
//     }
//   }

//   void _startScan() async {
//     setState(() {
//       isScanning = true;
//       scanResults.clear();
//     });

//     FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

//     FlutterBluePlus.scanResults.listen((results) {
//       setState(() {
//         scanResults.clear();
//         scanResults.addAll(results);
//       });

//       log('Scan results: ${scanResults.length}');
//     }).onDone(() {
//       setState(() {
//         isScanning = false;
//       });
//       FlutterBluePlus.stopScan();
//     });
//   }

//   void _toggleScan() {
//     if (isScanning) {
//       FlutterBluePlus.stopScan();
//     } else {
//       _startScan();
//     }
//   }

//   void _connectToDevice(BluetoothDevice device) async {
//     log("Connecting to ${device.remoteId}");
//     try {
//       await device.connect();
//       setState(() {
//         deviceConnectionState[device.remoteId.str] = true;
//         connectedDevices[device.remoteId.str] = device;
//       });

//       await Future.delayed(const Duration(seconds: 2));

//       if (device.isConnected) {
//         List<BluetoothService> services = await device.discoverServices();
//         log('Services discovered for ${device.remoteId}:');
//         for (var service in services) {
//           log('Service UUID: ${service.uuid}');
//           log('Characteristics: ${service.characteristics}');
//           log('Included Services: ${service.includedServices}');
//           log('Service UUID: ${service.serviceUuid}');
//         }
//       } else {
//         log('Device is not connected, cannot discover services.');
//       }
//     } catch (e) {
//       log('Error connecting to device: $e');
//     }
//   }

//   void _disconnectFromDevice(BluetoothDevice device) async {
//     log("Disconnecting from ${device.remoteId}");
//     try {
//       await device.disconnect();
//       setState(() {
//         deviceConnectionState[device.remoteId.str] = false;
//         connectedDevices.remove(device.remoteId.str);
//       });
//     } catch (e) {
//       log('Error disconnecting from device: $e');
//     }
//   }

//   void _restoreConnectedDevices() async {
//     for (var device in FlutterBluePlus.connectedDevices) {
//       setState(() {
//         deviceConnectionState[device.remoteId.str] = true;
//         connectedDevices[device.remoteId.str] = device;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (_adapterState != BluetoothAdapterState.on) {
//       return BluetoothOffScreen(adapterState: _adapterState);
//     }

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Scan for Devices'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               setState(() {
//                 scanResults.clear();
//               });
//               _startScan();
//             },
//           ),
//           IconButton(
//             icon: Icon(isScanning ? Icons.pause : Icons.play_arrow),
//             onPressed: _toggleScan,
//           ),
//         ],
//       ),
//       body: ListView.builder(
//         itemCount: scanResults.length + connectedDevices.length,
//         itemBuilder: (context, index) {
//           if (index < connectedDevices.length) {
//             final deviceEntry = connectedDevices.values.elementAt(index);
//             String deviceName = deviceEntry.platformName.isNotEmpty
//                 ? deviceEntry.platformName
//                 : "Connected Device";
//             bool isConnected =
//                 deviceConnectionState[deviceEntry.remoteId.str] ?? false;

//             return ListTile(
//               title: Text(deviceName),
//               subtitle: Text(
//                 'ID: ${deviceEntry.remoteId}',
//               ),
//               trailing: ElevatedButton(
//                 onPressed: () {
//                   if (isConnected) {
//                     _disconnectFromDevice(deviceEntry);
//                   } else {
//                     _connectToDevice(deviceEntry);
//                   }
//                 },
//                 child: Text(isConnected ? 'Disconnect' : 'Connect'),
//               ),
//             );
//           } else {
//             final result = scanResults[index - connectedDevices.length];
//             String deviceName = result.advertisementData.advName.isNotEmpty
//                 ? result.advertisementData.advName
//                 : "Unknown Device";
//             bool isConnectable = result.advertisementData.connectable;
//             bool isConnected =
//                 deviceConnectionState[result.device.remoteId.str] ?? false;

//             Widget trailingWidget = isConnectable
//                 ? ElevatedButton(
//                     onPressed: () {
//                       if (isConnected) {
//                         _disconnectFromDevice(result.device);
//                       } else {
//                         _connectToDevice(result.device);
//                       }
//                     },
//                     child: Text(isConnected ? 'Disconnect' : 'Connect'),
//                   )
//                 : const Text('Not Connectable');

//             return ListTile(
//               title: Text(deviceName),
//               subtitle: Text(
//                 'RSSI: ${result.rssi}, ID: ${result.device.remoteId}',
//               ),
//               trailing: trailingWidget,
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// class BluetoothOffScreen extends StatelessWidget {
//   final BluetoothAdapterState adapterState;

//   const BluetoothOffScreen({required this.adapterState, super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Bluetooth is Off')),
//       body: Center(
//         child: Text('Bluetooth adapter state: $adapterState'),
//       ),
//     );
//   }
// }
