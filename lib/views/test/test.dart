// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:get/get.dart';
// import '../../controllers/bluetooth_controller.dart';
// import '../../services/ble_service.dart';
// import '../../models/lead_model.dart';
//
//
// class TestScreen extends StatelessWidget {
//   final BleController bleController = Get.put(BleController());
//   final BleService bleService = BleService();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('13 Lead ECG Chart')),
//       body: Obx(() {
//         if (bleController.ecgData.isEmpty) {
//           return Center(child: Text('No ECG data available'));
//         }
//
//         // Contoh pembagian data ke dalam lead
//         List<Lead> leads = _prepareLeads(bleController.ecgData);
//
//         return LineChart(
//           LineChartData(
//             gridData: FlGridData(show: false),
//             titlesData: FlTitlesData(
//               // leftTitles: SideTitles(showTitles: true),
//               // bottomTitles: SideTitles(showTitles: true),
//             ),
//             borderData: FlBorderData(show: true),
//             minX: 0,
//             maxX: 100, // Adjust based on your data
//             minY: -1000, // Adjust based on your data
//             maxY: 1000, // Adjust based on your data
//             lineBarsData: leads.map((lead) {
//               return LineChartBarData(
//                 spots: lead.values.asMap().entries.map((entry) {
//                   int index = entry.key;
//                   int value = entry.value;
//                   return FlSpot(index.toDouble(), value.toDouble());
//                 }).toList(),
//                 isCurved: true,
//                 // colors: [Colors.blue],
//                 barWidth: 2,
//                 belowBarData: BarAreaData(show: false),
//               );
//             }).toList(),
//           ),
//         );
//       }),
//     );
//   }
//
//   List<Lead> _prepareLeads(List<int> ecgData) {
//     // Asumsikan kita memiliki 12 lead, Anda harus menyesuaikan sesuai dengan data yang Anda terima
//     List<Lead> leads = [];
//     for (int i = 0; i < 12; i++) {
//       leads.add(Lead(name: 'Lead $i', values: ecgData.sublist(i * 100, (i + 1) * 100)));
//     }
//     return leads;
//   }
// }






import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import '../../controllers/bluetooth_controller.dart';
import '../../services/ble_service.dart';
import '../../models/lead_model.dart';
import '../ecg/component/ecg_lead_chart.dart';

class TestScreen extends StatelessWidget {
  final BleController bleController = Get.put(BleController());
  final BleService bleService = BleService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('13 Lead ECG Chart')),
      body: Obx(() {
        if (bleController.ecgData.isEmpty) {
          return Center(child: Text('No ECG data available'));
        }

        // Mengambil data ECG dari BLE service
        Map<String, List<double>> ecgLeads = bleService.extractEcgData(bleController.ecgData);

        return ListView(
          children: ecgLeads.keys.map((leadName) {
            return EcgLeadChart(
              leadData: ecgLeads[leadName]!,
              leadName: leadName,
            );
          }).toList(),
        );
      }),
    );
  }
}

























































// import 'package:ble_flutter/controllers/bluetooth_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:get/get.dart';
//
// class EcgScreen extends StatelessWidget {
//   const EcgScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('ECG Device Scanner'),
//         actions: [
//           GetBuilder<BleController>(
//             init: BleController(),
//             builder: (controller) {
//               return Obx(() => IconButton(
//                 icon: Icon(controller.isConnected.value
//                     ? Icons.bluetooth_connected
//                     : Icons.bluetooth_disabled),
//                 onPressed: () {
//                   if (controller.isConnected.value) {
//                     controller.disconnect();
//                   } else {
//                     controller.scanDevices();
//                   }
//                 },
//               ));
//             },
//           ),
//         ],
//       ),
//       body: GetBuilder<BleController>(
//         init: BleController(),
//         builder: (controller) {
//           return SingleChildScrollView(
//             child: Center(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 20),
//                   const Text(
//                     "ECG Device Scanner",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 20),
//
//                   // Scan Button
//                   Obx(() => ElevatedButton.icon(
//                     onPressed: controller.isScanning.value
//                         ? null
//                         : () => controller.scanDevices(),
//                     icon: controller.isScanning.value
//                         ? const SizedBox(
//                       width: 20,
//                       height: 20,
//                       child: CircularProgressIndicator(
//                         strokeWidth: 2,
//                       ),
//                     )
//                         : const Icon(Icons.search),
//                     label: Text(controller.isScanning.value
//                         ? "Scanning..."
//                         : "Start Scan"),
//                   )),
//                   const SizedBox(height: 20),
//
//                   // Connection Status Card
//                   Obx(() {
//                     if (controller.isConnected.value) {
//                       return Card(
//                         color: Colors.green[100],
//                         margin: const EdgeInsets.all(16.0),
//                         child: ListTile(
//                           leading: const Icon(Icons.bluetooth_connected),
//                           title: Text(
//                               'Connected to: ${controller.connectedDevice.value?.name ?? "Unknown Device"}'),
//                           subtitle: Text(
//                               'Device ID: ${controller.connectedDevice.value?.id.id ?? ""}'),
//                           trailing: IconButton(
//                             icon: const Icon(Icons.dangerous),
//                             onPressed: () => controller.disconnect(),
//                           ),
//                         ),
//                       );
//                     }
//                     return const SizedBox.shrink();
//                   }),
//
//                   // Service & Characteristic Information Card
//                   Obx(() {
//                     if (controller.isConnected.value &&
//                         controller.ecgService.value != null &&
//                         controller.ecgCharacteristic.value != null) {
//                       return Card(
//                         margin: const EdgeInsets.all(16.0),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               const Text(
//                                 "ECG Service Information",
//                                 style: TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.bold),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                   'Service UUID: ${controller.ecgService.value!.uuid}'),
//                               Text(
//                                   'Characteristic UUID: ${controller.ecgCharacteristic.value!.uuid}'),
//                               const SizedBox(height: 8),
//                               Text(
//                                   'Properties: ${_getCharacteristicProperties(controller.ecgCharacteristic.value!)}'),
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                     return const SizedBox.shrink();
//                   }),
//
//                   // Scan Results
//                   Obx(() {
//                     if (controller.isScanning.value) {
//                       return const Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Column(
//                           children: [
//                             CircularProgressIndicator(),
//                             SizedBox(height: 8),
//                             Text("Scanning for devices..."),
//                           ],
//                         ),
//                       );
//                     }
//
//                     final results = controller.scanResults;
//
//                     if (results.isEmpty) {
//                       return const Padding(
//                         padding: EdgeInsets.all(16.0),
//                         child: Text("No devices found"),
//                       );
//                     }
//
//                     return ListView.builder(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       itemCount: results.length,
//                       itemBuilder: (context, index) {
//                         final data = results[index];
//                         return Card(
//                           margin: const EdgeInsets.symmetric(
//                               horizontal: 16.0, vertical: 4.0),
//                           child: ListTile(
//                             title: Text(data.device.name.isNotEmpty
//                                 ? data.device.name
//                                 : 'Unknown Device'),
//                             subtitle: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text('ID: ${data.device.id.id}'),
//                                 Text('Signal Strength: ${data.rssi} dBm'),
//                               ],
//                             ),
//                             trailing: Obx(() => ElevatedButton(
//                               onPressed: controller.isConnected.value
//                                   ? null
//                                   : () => controller
//                                   .connectToDevice(data.device),
//                               child: Text(controller.isConnected.value &&
//                                   controller
//                                       .connectedDevice.value?.id ==
//                                       data.device.id
//                                   ? 'Connected'
//                                   : 'Connect'),
//                             )),
//                           ),
//                         );
//                       },
//                     );
//                   }),
//
//                   // ECG Data Display
//                   Obx(() {
//                     if (controller.isConnected.value &&
//                         controller.ecgData.isNotEmpty) {
//                       return Card(
//                         margin: const EdgeInsets.all(16.0),
//                         child: Padding(
//                           padding: const EdgeInsets.all(16.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     "ECG Data",
//                                     style: TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold),
//                                   ),
//                                   Text('Samples: ${controller.ecgData.length}',
//                                       style: const TextStyle(
//                                           fontSize: 14, color: Colors.grey)),
//                                 ],
//                               ),
//                               const SizedBox(height: 16),
//                               // Simple ECG Visualization
//                               SizedBox(
//                                 height: 200,
//                                 child: CustomPaint(
//                                   size: Size.infinite,
//                                   painter: EcgPainter(controller.ecgData),
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Row(
//                                 mainAxisAlignment:
//                                 MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Text(
//                                       'Latest Value: ${controller.ecgData.lastOrNull ?? "No data"}'),
//                                   ElevatedButton.icon(
//                                     onPressed: () => controller.ecgData.clear(),
//                                     icon: const Icon(Icons.clear),
//                                     label: const Text("Clear Data"),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }
//                     return const SizedBox.shrink();
//                   }),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   String _getCharacteristicProperties(BluetoothCharacteristic characteristic) {
//     List<String> properties = [];
//     if (characteristic.properties.read) properties.add('Read');
//     if (characteristic.properties.write) properties.add('Write');
//     if (characteristic.properties.notify) properties.add('Notify');
//     if (characteristic.properties.indicate) properties.add('Indicate');
//     if (characteristic.properties.broadcast) properties.add('Broadcast');
//     if (characteristic.properties.writeWithoutResponse) {
//       properties.add('Write Without Response');
//     }
//     return properties.join(', ');
//   }
// }
//
// // Custom Painter untuk visualisasi ECG
// class EcgPainter extends CustomPainter {
//   final List<int> data;
//
//   EcgPainter(this.data);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.red
//       ..strokeWidth = 2
//       ..style = PaintingStyle.stroke;
//
//     final path = Path();
//     if (data.isEmpty) return;
//
//     final pointsCount = data.length;
//     final dx = size.width / (pointsCount - 1);
//     final maxValue = data.reduce((max, value) => max > value ? max : value);
//     final minValue = data.reduce((min, value) => min < value ? min : value);
//     final range = maxValue - minValue;
//     final scale = size.height / (range == 0 ? 1 : range);
//
//     path.moveTo(0, size.height - (data[0] - minValue) * scale);
//
//     for (int i = 1; i < pointsCount; i++) {
//       path.lineTo(
//         dx * i,
//         size.height - (data[i] - minValue) * scale,
//       );
//     }
//
//     canvas.drawPath(path, paint);
//
//     // Draw grid
//     final gridPaint = Paint()
//       ..color = Colors.grey.withOpacity(0.3)
//       ..strokeWidth = 0.5;
//
//     // Vertical grid lines
//     for (double x = 0; x < size.width; x += size.width / 10) {
//       canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
//     }
//
//     // Horizontal grid lines
//     for (double y = 0; y < size.height; y += size.height / 5) {
//       canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
//     }
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }
