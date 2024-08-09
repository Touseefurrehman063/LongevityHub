import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:longevity_hub/data/controller/ble_controller/ble_conroller.dart';

class BLEDeviceDataScreen extends StatefulWidget {
  const BLEDeviceDataScreen({Key? key}) : super(key: key);

  @override
  State<BLEDeviceDataScreen> createState() => _BLEDeviceDataScreenState();
}

class _BLEDeviceDataScreenState extends State<BLEDeviceDataScreen> {
  late BluetoothDevice device;
  List<BluetoothService> services = [];

  StreamSubscription<List<int>>? heartRateSubscription;
  StreamSubscription<List<int>>? sleepDataSubscription;

  @override
  void initState() {
    super.initState();
    device = BleController.i.connectedDevices.values.first;
    _discoverServices();
  }

  @override
  void dispose() {
    heartRateSubscription?.cancel();
    sleepDataSubscription?.cancel();
    super.dispose();
  }

  Future<void> _discoverServices() async {
    try {
      services = await device.discoverServices();
      setState(() {
        _retrieveHeartRateData();
        _retrieveSleepData();
      });
    } catch (e) {
      log('Error discovering services: $e');
    }
  }

  Future<void> _retrieveHeartRateData() async {
    for (var service in services) {
      if (service.uuid.toString() == '0000180d-0000-1000-8000-00805f9b34fb') {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString() ==
              '00002a37-0000-1000-8000-00805f9b34fb') {
            if (characteristic.properties.notify) {
              await characteristic.setNotifyValue(true);
              heartRateSubscription = characteristic.lastValueStream.listen(
                (value) {
                  // Log the raw byte array
                  log('Received notification from ${characteristic.uuid}: $value');

                  // Convert byte array to hex string for readability
                  String hexValue = value
                      .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
                      .join('-');
                  log('Hex Value: $hexValue');

                  // Check if value is not empty and update heart rate
                  if (value.isNotEmpty) {
                    log('First byte value: ${value.first}');
                    // Uncomment and adjust the logic as needed
                    // setState(() {
                    //   heartRate = value.isNotEmpty
                    //       ? value[1] // Adjust index if needed
                    //       : 0;
                    // });
                  }
                },
                onError: (error) {
                  log('Error in heart rate characteristic value stream: $error');
                },
              );
              device.cancelWhenDisconnected(heartRateSubscription!);
            } else {
              log('Heart Rate Characteristic does not support notifications.');
            }
          }
        }
      }
    }
  }

  Future<void> _retrieveSleepData() async {
    for (var service in services) {
      if (service.uuid.toString() == 'YOUR_SLEEP_DATA_SERVICE_UUID') {
        for (var characteristic in service.characteristics) {
          if (characteristic.uuid.toString() ==
              'YOUR_SLEEP_DATA_CHARACTERISTIC_UUID') {
            if (characteristic.properties.notify) {
              await characteristic.setNotifyValue(true);
              sleepDataSubscription = characteristic.lastValueStream.listen(
                (value) {
                  // Log the raw byte array
                  log('Received notification from ${characteristic.uuid}: $value');

                  // Convert byte array to hex string for readability
                  String hexValue = value
                      .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
                      .join('-');
                  log('Hex Value: $hexValue');

                  // Update sleep data
                  setState(() {});
                },
                onError: (error) {
                  log('Error in sleep data characteristic value stream: $error');
                },
              );
              device.cancelWhenDisconnected(sleepDataSubscription!);
            } else {
              log('Sleep Data Characteristic does not support notifications.');
            }
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Data'),
      ),
      body: services.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      BluetoothService service = services[index];
                      return ExpansionTile(
                        title: Text(service.uuid.toString()),
                        children: service.characteristics.map((characteristic) {
                          String buttonText;
                          if (characteristic.properties.notify) {
                            buttonText = 'Notify';
                          } else if (characteristic.properties.read) {
                            buttonText = 'Read';
                          } else if (characteristic.properties.write) {
                            buttonText = 'Write';
                          } else if (characteristic.properties.indicate) {
                            buttonText = 'Indicate';
                          } else {
                            buttonText = 'Unsupported';
                          }

                          return ListTile(
                            title: Text(characteristic.uuid.toString()),
                            trailing: ElevatedButton(
                              onPressed: () async {
                                if (characteristic.properties.notify) {
                                  await characteristic.setNotifyValue(true);
                                  log('Notifications enabled for ${characteristic.uuid}');
                                } else if (characteristic.properties.read) {
                                  List<int> value = await characteristic.read();
                                  log('Read value from ${characteristic.uuid}: $value');
                                } else if (characteristic.properties.write) {
                                  List<int> writeValue = [1, 2, 3, 4];
                                  try {
                                    await characteristic.write(writeValue);
                                    log('Written value to ${characteristic.uuid}: $writeValue');
                                  } catch (e) {
                                    log('Error writing to characteristic ${characteristic.uuid}: $e');
                                  }
                                } else if (characteristic.properties.indicate) {
                                  try {
                                    await characteristic.setNotifyValue(true);
                                    characteristic.lastValueStream.listen(
                                      (value) {
                                        log('Received notification from ${characteristic.uuid}: $value');
                                      },
                                      onError: (error) {
                                        log('Error in indication characteristic value stream: $error');
                                      },
                                    );
                                  } catch (e) {
                                    log('Error setting up indications for ${characteristic.uuid}: $e');
                                  }
                                } else {
                                  log('Characteristic ${characteristic.uuid} does not support actions');
                                }
                              },
                              child: Text(buttonText),
                            ),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}













// import 'dart:async';
// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import '../../data/controller/ble_controller.dart/ble_controller.dart';

// class BLEDeviceDataScreen extends StatefulWidget {
//   const BLEDeviceDataScreen({Key? key}) : super(key: key);

//   @override
//   State<BLEDeviceDataScreen> createState() => _BLEDeviceDataScreenState();
// }

// class _BLEDeviceDataScreenState extends State<BLEDeviceDataScreen> {
//   late BluetoothDevice device;
//   List<BluetoothService> services = [];
//   int heartRate = 0;
//   String sleepData = '';
//   StreamSubscription<List<int>>? heartRateSubscription;
//   StreamSubscription<List<int>>? sleepDataSubscription;

//   @override
//   void initState() {
//     super.initState();
//     device = BleController.i.connectedDevices.values.first;
//     _discoverServices();
//   }

//   @override
//   void dispose() {
//     heartRateSubscription?.cancel();
//     sleepDataSubscription?.cancel();
//     super.dispose();
//   }

//   Future<void> _discoverServices() async {
//     try {
//       services = await device.discoverServices();
//       setState(() {
//         _retrieveHeartRateData();
//         _retrieveSleepData();
//       });
//     } catch (e) {
//       log('Error discovering services: $e');
//     }
//   }

//   Future<void> _retrieveHeartRateData() async {
//     for (var service in services) {
//       if (service.uuid.toString() == '0000180d-0000-1000-8000-00805f9b34fb') {
//         for (var characteristic in service.characteristics) {
//           if (characteristic.uuid.toString() ==
//               '00002a37-0000-1000-8000-00805f9b34fb') {
//             if (characteristic.properties.notify) {
//               await characteristic.setNotifyValue(true);
//               heartRateSubscription =
//                   characteristic.lastValueStream.listen((value) {
//                 log('Received notification from ${characteristic.uuid}: $value');
//                 log('Hex Value: ${value.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('-')}');
//                 if (value.isNotEmpty) {
//                   setState(() {
//                     heartRate = value.isNotEmpty
//                         ? value[1]
//                         : 0; // Adjust as per the data format
//                   });
//                 }
//               }, onError: (error) {
//                 log('Error in characteristic value stream: $error');
//               });
//               device.cancelWhenDisconnected(heartRateSubscription!);
//             }
//             if (characteristic.properties.read) {
//               try {
//                 List<int> readValue = await characteristic.read();
//                 log('Read value from ${characteristic.uuid}: $readValue');
//                 setState(() {
//                   heartRate = readValue.isNotEmpty
//                       ? readValue[1]
//                       : 0; // Adjust as per the data format
//                 });
//               } catch (e) {
//                 log('Error reading characteristic ${characteristic.uuid}: $e');
//               }
//             }
//           }
//         }
//       }
//     }
//   }

//   Future<void> _retrieveSleepData() async {
//     for (var service in services) {
//       if (service.uuid.toString() == 'YOUR_SLEEP_DATA_SERVICE_UUID') {
//         for (var characteristic in service.characteristics) {
//           if (characteristic.uuid.toString() ==
//               'YOUR_SLEEP_DATA_CHARACTERISTIC_UUID') {
//             if (characteristic.properties.notify) {
//               await characteristic.setNotifyValue(true);
//               sleepDataSubscription =
//                   characteristic.lastValueStream.listen((value) {
//                 log('Received notification from ${characteristic.uuid}: $value');
//                 setState(() {
//                   sleepData = value.isNotEmpty
//                       ? String.fromCharCodes(value)
//                       : 'No Data';
//                 });
//               }, onError: (error) {
//                 log('Error in characteristic value stream: $error');
//               });
//               device.cancelWhenDisconnected(sleepDataSubscription!);
//             }
//           }
//         }
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Device Data'),
//       ),
//       body: services.isEmpty
//           ? const Center(child: CircularProgressIndicator())
//           : Column(
//               children: [
//                 Text('Heart Rate: $heartRate bpm',
//                     style: const TextStyle(fontSize: 20)),
//                 Text('Sleep Data: $sleepData',
//                     style: const TextStyle(fontSize: 20)),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount: services.length,
//                     itemBuilder: (context, index) {
//                       BluetoothService service = services[index];
//                       return ExpansionTile(
//                         title: Text(service.uuid.toString()),
//                         children: service.characteristics.map((characteristic) {
//                           String buttonText;
//                           if (characteristic.properties.notify) {
//                             buttonText = 'Notify';
//                           } else if (characteristic.properties.read) {
//                             buttonText = 'Read';
//                           } else if (characteristic.properties.write) {
//                             buttonText = 'Write';
//                           } else if (characteristic.properties.indicate) {
//                             buttonText = 'Indicate';
//                           } else {
//                             buttonText = 'Unsupported';
//                           }

//                           return ListTile(
//                             title: Text(characteristic.uuid.toString()),
//                             trailing: ElevatedButton(
//                               onPressed: () async {
//                                 if (characteristic.properties.notify) {
//                                   await characteristic.setNotifyValue(true);
//                                   log('Notifications enabled for ${characteristic.uuid}');
//                                 } else if (characteristic.properties.read) {
//                                   List<int> value = await characteristic.read();
//                                   log('Read value from ${characteristic.uuid}: $value');
//                                 } else if (characteristic.properties.write) {
//                                   List<int> writeValue = [1, 2, 3, 4];
//                                   try {
//                                     await characteristic.write(writeValue);
//                                     log('Written value to ${characteristic.uuid}: $writeValue');
//                                   } catch (e) {
//                                     log('Error writing to characteristic ${characteristic.uuid}: $e');
//                                   }
//                                 } else if (characteristic.properties.indicate) {
//                                   try {
//                                     await characteristic.setNotifyValue(true);
//                                     characteristic.lastValueStream.listen(
//                                         (value) {
//                                       log('Received notification from ${characteristic.uuid}: $value');
//                                     }, onError: (error) {
//                                       log('Error in characteristic value stream: $error');
//                                     });
//                                   } catch (e) {
//                                     log('Error setting up indications for ${characteristic.uuid}: $e');
//                                   }
//                                 } else {
//                                   log('Characteristic ${characteristic.uuid} does not support actions');
//                                 }
//                               },
//                               child: Text(buttonText),
//                             ),
//                           );
//                         }).toList(),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             ),
//     );
//   }
// }
