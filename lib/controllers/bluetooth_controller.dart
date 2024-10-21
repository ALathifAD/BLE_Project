// ble_controller.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';
import '../services/ble_service.dart'; // Import BLE Service

class BleController extends GetxController {
  // Inisialisasi Service BLE
  final BleService bleService = BleService();

  // Variables untuk tracking state
  final isScanning = false.obs;
  final isConnected = false.obs;
  final connectedDevice = Rxn<BluetoothDevice>();
  final ecgData = RxList<int>([]);
  final scanResults = <ScanResult>[].obs;

  // Variables untuk menyimpan service dan characteristic yang ditemukan
  final discoveredServices = RxList<BluetoothService>([]);
  Rxn<BluetoothService> ecgService = Rxn<BluetoothService>();
  Rxn<BluetoothCharacteristic> ecgCharacteristic =
  Rxn<BluetoothCharacteristic>();

  @override
  void onInit() {
    super.onInit();
    initBle();
  }

  Future<void> initBle() async {
    // Initialize BLE
    try {
      FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
    } catch (e) {
      debugPrint("Error initializing BLE: $e");
    }
  }

  // Fungsi untuk menemukan dan subscribe ke characteristic ECG
  Future<bool> _findEcgService(List<BluetoothService> services) async {
    discoveredServices.value = services;

    for (var service in services) {
      for (var characteristic in service.characteristics) {
        if (characteristic.properties.notify ||
            characteristic.properties.indicate) {
          try {
            await characteristic.setNotifyValue(true);
            characteristic.value.listen((value) {
              if (value.isNotEmpty) {
                ecgService.value = service;
                ecgCharacteristic.value = characteristic;
                ecgData.addAll(value);

                // Proses data ECG menggunakan BleService
                final extractedData = bleService.extractEcgData(ecgData);
                debugPrint("Extracted ECG Data: $extractedData");

                if (ecgData.length > 1000) {
                  ecgData.removeRange(0, ecgData.length - 1000);
                }
              }
            });

            await Future.delayed(const Duration(milliseconds: 500));
            if (ecgData.isNotEmpty) {
              return true;
            }
          } catch (e) {
            debugPrint("Error testing characteristic: $e");
            continue;
          }
        }
      }
    }
    return false;
  }

  // Fungsi connect dan discover services
  Future<void> connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      connectedDevice.value = device;
      final services = await device.discoverServices();
      final found = await _findEcgService(services);

      if (found) {
        isConnected.value = true;
      } else {
        await disconnect();
      }
    } catch (e) {
      debugPrint("Error connecting: $e");
    }
  }

  Future<void> disconnect() async {
    try {
      if (connectedDevice.value != null) {
        if (ecgCharacteristic.value != null) {
          await ecgCharacteristic.value!.setNotifyValue(false);
        }

        await connectedDevice.value!.disconnect();
        isConnected.value = false;
        connectedDevice.value = null;
        ecgService.value = null;
        ecgCharacteristic.value = null;
        ecgData.clear();
        discoveredServices.clear();
      }
    } catch (e) {
      debugPrint("Error disconnecting: $e");
    }
  }
}


















// simulation










// // ignore_for_file: deprecated_member_use
//
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:get/get.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class BleController extends GetxController {
//   // Variables untuk tracking state
//   final isScanning = false.obs;
//   final isConnected = false.obs;
//   final connectedDevice = Rxn<BluetoothDevice>();
//   final ecgData = RxList<int>([]);
//   final scanResults = <ScanResult>[].obs;
//
//   // Variables untuk menyimpan service dan characteristic yang ditemukan
//   final discoveredServices = RxList<BluetoothService>([]);
//   Rxn<BluetoothService> ecgService = Rxn<BluetoothService>();
//   Rxn<BluetoothCharacteristic> ecgCharacteristic =
//   Rxn<BluetoothCharacteristic>();
//
//   @override
//   void onInit() {
//     super.onInit();
//     initBle();
//   }
//
//   Future<void> initBle() async {
//     try {
//       FlutterBluePlus.setLogLevel(LogLevel.verbose, color: true);
//     } catch (e) {
//       debugPrint("Error initializing BLE: $e");
//     }
//   }
//
//   Future<void> scanDevices() async {
//     try {
//       // Clear hasil scan sebelumnya
//       scanResults.clear();
//
//       if (!await _checkPermissions()) {
//         Get.snackbar(
//           'Permission Error',
//           'Izin Bluetooth dan Lokasi diperlukan',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }
//
//       // Check if bluetooth is turned on
//       if (!(await FlutterBluePlus.isSupported)) {
//         Get.snackbar(
//           'Error',
//           'Bluetooth tidak didukung pada device ini',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }
//
//       final isOn = await FlutterBluePlus.isOn;
//       if (!isOn) {
//         Get.snackbar(
//           'Error',
//           'Bluetooth tidak aktif. Mohon aktifkan Bluetooth',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         return;
//       }
//
//       // Stop any existing scan
//       if (isScanning.value) {
//         await FlutterBluePlus.stopScan();
//         isScanning.value = false;
//       }
//
//       // Start scanning
//       isScanning.value = true;
//
//       // Subscribe to scan results
//       FlutterBluePlus.scanResults.listen(
//             (results) {
//           scanResults.value = results;
//         },
//         onError: (e) {
//           debugPrint("Error during scan: $e");
//           Get.snackbar(
//             'Scan Error',
//             'Terjadi kesalahan saat scanning',
//             snackPosition: SnackPosition.BOTTOM,
//           );
//         },
//       );
//
//       // Start the scan
//       await FlutterBluePlus.startScan(
//         timeout: const Duration(seconds: 10),
//         androidUsesFineLocation: true,
//       );
//
//       // After timeout
//       await Future.delayed(const Duration(seconds: 10));
//       if (isScanning.value) {
//         await FlutterBluePlus.stopScan();
//         isScanning.value = false;
//       }
//     } catch (e) {
//       debugPrint("Error scanning: $e");
//       Get.snackbar(
//         'Error',
//         'Terjadi kesalahan saat scanning',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       isScanning.value = false;
//     }
//   }
//
//   // Fungsi untuk mencari service ECG
//   Future<bool> _findEcgService(List<BluetoothService> services) async {
//     discoveredServices.value = services;
//
//     // Cari service yang memiliki characteristic dengan properties notify/indicate
//     // yang biasanya digunakan untuk streaming data sensor
//     for (var service in services) {
//       for (var characteristic in service.characteristics) {
//         if (characteristic.properties.notify ||
//             characteristic.properties.indicate) {
//           // Coba subscribe ke characteristic ini
//           try {
//             await characteristic.setNotifyValue(true);
//             characteristic.value.listen((value) {
//               if (value.isNotEmpty) {
//                 // Jika berhasil menerima data, kemungkinan ini adalah ECG characteristic
//                 ecgService.value = service;
//                 ecgCharacteristic.value = characteristic;
//                 ecgData.addAll(value);
//                 if (ecgData.length > 1000) {
//                   ecgData.removeRange(0, ecgData.length - 1000);
//                 }
//                 debugPrint("Received ECG data: $value");
//               }
//             });
//
//             // Tunggu sebentar untuk melihat apakah ada data yang masuk
//             await Future.delayed(const Duration(milliseconds: 500));
//             if (ecgData.isNotEmpty) {
//               debugPrint("Found ECG Service: ${service.uuid}");
//               debugPrint("Found ECG Characteristic: ${characteristic.uuid}");
//               return true;
//             }
//           } catch (e) {
//             debugPrint("Error testing characteristic: $e");
//             continue;
//           }
//         }
//       }
//     }
//     return false;
//   }
//
//   Future<void> connectToDevice(BluetoothDevice device) async {
//     try {
//       await device.connect(timeout: const Duration(seconds: 5));
//       connectedDevice.value = device;
//
//       // Discover services
//       final services = await device.discoverServices();
//
//       // Cari service ECG
//       final found = await _findEcgService(services);
//
//       if (found) {
//         isConnected.value = true;
//         Get.snackbar(
//           'Connected',
//           'Terhubung dengan ${device.name.isEmpty ? "Unknown Device" : device.name}',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       } else {
//         Get.snackbar(
//           'Warning',
//           'Tidak menemukan service ECG pada device ini',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//         await disconnect();
//       }
//     } catch (e) {
//       debugPrint("Error connecting: $e");
//       Get.snackbar(
//         'Connection Error',
//         'Gagal terhubung dengan device',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
//
//   Future<void> disconnect() async {
//     try {
//       if (connectedDevice.value != null) {
//         // Unsubscribe dari characteristic
//         if (ecgCharacteristic.value != null) {
//           await ecgCharacteristic.value!.setNotifyValue(false);
//         }
//
//         await connectedDevice.value!.disconnect();
//         isConnected.value = false;
//         connectedDevice.value = null;
//         ecgService.value = null;
//         ecgCharacteristic.value = null;
//         ecgData.clear();
//         discoveredServices.clear();
//
//         Get.snackbar(
//           'Disconnected',
//           'Berhasil memutuskan koneksi',
//           snackPosition: SnackPosition.BOTTOM,
//         );
//       }
//     } catch (e) {
//       debugPrint("Error disconnecting: $e");
//       Get.snackbar(
//         'Disconnect Error',
//         'Gagal memutuskan koneksi',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
//
//   Future<bool> _checkPermissions() async {
//     bool permissionsGranted = true;
//
//     if (!await Permission.location.isGranted) {
//       final status = await Permission.location.request();
//       permissionsGranted = status.isGranted;
//     }
//
//     if (!await Permission.bluetoothScan.isGranted) {
//       final status = await Permission.bluetoothScan.request();
//       permissionsGranted = status.isGranted;
//     }
//
//     if (!await Permission.bluetoothConnect.isGranted) {
//       final status = await Permission.bluetoothConnect.request();
//       permissionsGranted = status.isGranted;
//     }
//
//     return permissionsGranted;
//   }
//
//   @override
//   void onClose() {
//     FlutterBluePlus.stopScan();
//     disconnect();
//     super.onClose();
//   }
// }
