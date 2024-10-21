import 'package:ble_flutter/views/ecg/ecg_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ble_flutter/controllers/bluetooth_controller.dart'; // Import controller yang benar

void main() {
  // Inisialisasi BleController sebelum menjalankan aplikasi
  Get.put(BleController()); // Ini untuk memastikan BleController selalu diinisialisasi ketika aplikasi mulai

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'BLE Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EcgScreen(), // Tampilan utama
    );
  }
}



















// import 'package:ble_flutter/views/test/test.dart';
// import 'package:flutter/material.dart';
// import 'views/ecg/ecg_screen.dart';
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(),
//       // home: const EcgScreen(),
//       home: EcgScreen(),
//     );
//   }
// }
