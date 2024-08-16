// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, no_leading_underscores_for_local_identifiers, unused_element

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:longevity_hub/data/controller/ble_controller/ble_conroller.dart';
import 'package:longevity_hub/data/controller/health_insights_controller/health_insights_controller.dart';

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
      if (service.uuid.toString() == 'feea') {
        for (var characteristic in service.characteristics) {
          log('Characteristic UUID: ${characteristic.uuid.toString()}');
          if (characteristic.uuid.toString() == 'fee3') {
            if (characteristic.properties.notify) {
              try {
                await characteristic.setNotifyValue(true);
                log('Notifications enabled for ${characteristic.uuid}');
                heartRateSubscription = characteristic.value.listen(
                  (value) {
                    log('Received value: $value');
                    if (value.isNotEmpty) {
                      try {
                        int heartRate = 0;
                        int flags = value[0];
                        log('Flags: $flags');
                        if ((flags & 0x01) == 0) {
                          heartRate = value[5];
                        } else {
                          heartRate =
                              (value[1] & 0xFF) | ((value[2] & 0xFF) << 8);
                        }
                        log('Heart Rate: $heartRate bpm');
                        setState(() {
                          HealthInsightsController.i.newheartRate = heartRate;
                        });
                      } catch (e) {
                        log('Error parsing heart rate data: $e');
                      }
                    } else {
                      log('Received empty heart rate value');
                    }
                  },
                  onError: (error) {
                    log('Error in heart rate characteristic value stream: $error');
                  },
                );
              } catch (e) {
                log('Error setting notify value: $e');
              }
            } else {
              log('Heart Rate Characteristic does not support notifications.');
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
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Heart Rate: ${HealthInsightsController.i.newheartRate != null ? '${HealthInsightsController.i.newheartRate} bpm' : 'No data'}',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      BluetoothService service = services[index];
                      return ExpansionTile(
                        title: Text(service.uuid.toString()),
                        children: service.characteristics.map((characteristic) {
                          String buttonText = _getButtonText(characteristic);

                          return ListTile(
                            title: Text(characteristic.uuid.toString()),
                            trailing: ElevatedButton(
                              onPressed: () =>
                                  _handleButtonPress(characteristic),
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

  String _getButtonText(BluetoothCharacteristic characteristic) {
    if (characteristic.properties.notify) {
      return 'Notify';
    } else if (characteristic.properties.read) {
      return 'Read';
    } else if (characteristic.properties.write) {
      return 'Write';
    } else if (characteristic.properties.indicate) {
      return 'Indicate';
    } else {
      return 'Unsupported';
    }
  }

  Future<void> _handleButtonPress(
      BluetoothCharacteristic characteristic) async {
    await _retrieveHeartRateData();
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
        characteristic.value.listen(
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
  }
}
