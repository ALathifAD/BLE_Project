// ecg_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/bluetooth_controller.dart';

class EcgScreen extends StatelessWidget {
  final BleController bleController = Get.find<BleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ECG Data'),
      ),
      body: Obx(() {
        if (!bleController.isConnected.value) {
          return const Center(
            child: Text('No ECG device connected'),
          );
        }

        // Tampilan untuk menampilkan data ECG
        return ListView.builder(
          itemCount: bleController.ecgData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('ECG Lead I: ${bleController.ecgData[index]}'),
            );
          },
        );
      }),
    );
  }
}


















// simulation












// // ignore_for_file: library_private_types_in_public_api
//
// import 'dart:async';
// import 'dart:math';
// import 'package:ble_flutter/theme.dart';
// import 'package:ble_flutter/util/dimensions.dart';
// import 'package:ble_flutter/views/report/report_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// class ECGMonitorScreen extends StatefulWidget {
//   const ECGMonitorScreen({super.key});
//
//   @override
//   _ECGMonitorScreenState createState() => _ECGMonitorScreenState();
// }
//
// class _ECGMonitorScreenState extends State<ECGMonitorScreen> {
//   int timerCount = 0;
//   Timer? timer;
//   bool isRecording = false;
//
//   void toggleRecording() {
//     if (isRecording) {
//       timer?.cancel();
//     } else {
//       startTimer();
//     }
//     setState(() {
//       isRecording = !isRecording;
//     });
//   }
//
//   void startTimer() {
//     timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
//       if (timerCount >= 10) {
//         timer.cancel();
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const ReportScreen()),
//         );
//       } else {
//         setState(() {
//           timerCount += 1;
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.canPop(context);
//             },
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             )),
//         backgroundColor: Colors.blue,
//         title: Text(
//           'XXXXXXXX',
//           style: primaryTextStyle2.copyWith(color: Colors.white),
//         ),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: CustomScrollView(
//               slivers: [
//                 SliverGrid(
//                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                     crossAxisSpacing: 0.0,
//                     mainAxisSpacing: 0.0,
//                   ),
//                   delegate: SliverChildListDelegate([
//                     const ECGDiagram(title: 'I'),
//                     const ECGDiagram(title: 'V1'),
//                     const ECGDiagram(title: 'II'),
//                     const ECGDiagram(title: 'V2'),
//                     const ECGDiagram(title: 'III'),
//                     const ECGDiagram(title: 'V3'),
//                     const ECGDiagram(title: 'aVr'),
//                     const ECGDiagram(title: 'V4'),
//                     const ECGDiagram(title: 'aVL'),
//                     const ECGDiagram(title: 'V5'),
//                     const ECGDiagram(title: 'aVF'),
//                     const ECGDiagram(title: 'V6'),
//                   ]),
//                 ),
//                 const SliverToBoxAdapter(
//                   child: SizedBox(
//                     height: 200, // Adjust height as needed
//                     child: ECGDiagram(
//                       title: 'II Large',
//                       isLarge: true,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Row(
//                   children: [
//                     const Icon(Icons.favorite_border_outlined,
//                         color: Colors.red),
//                     const SizedBox(width: 2),
//                     Text(
//                       'xx',
//                       style: primaryTextStyle3.copyWith(
//                           color: Colors.white,
//                           fontSize: Dimensions.FONT_SIZE_EXTRA_MID_LARGE),
//                     ),
//                   ],
//                 ),
//                 GestureDetector(
//                   onTap: toggleRecording,
//                   child: Container(
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       border: Border.all(
//                         color: Colors.white,
//                         width: 2,
//                       ),
//                     ),
//                     child: CircleAvatar(
//                       radius: 20,
//                       backgroundColor: Colors.black,
//                       child: isRecording
//                           ? const Icon(
//                         Icons.stop,
//                         size: 30,
//                         color: Colors.redAccent,
//                       )
//                           : const Icon(
//                         Icons.play_arrow,
//                         size: 30,
//                         color: Colors.redAccent,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Text(
//                   '$timerCount s/10s',
//                   style: primaryTextStyle2.copyWith(
//                       color: Colors.white,
//                       fontSize: Dimensions.FONT_SIZE_EXTRA_MID_LARGE),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ECGDiagram extends StatelessWidget {
//   final String title;
//   final bool isLarge;
//
//   const ECGDiagram({
//     super.key,
//     required this.title,
//     this.isLarge = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned(
//           left: 15,
//           top: 12,
//           child: Text(
//             title,
//             style: const TextStyle(fontSize: 24, color: Colors.white),
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.all(1),
//           child: ECGChart(isLarge: isLarge),
//         ),
//       ],
//     );
//   }
// }
//
// class ECGChart extends StatefulWidget {
//   final bool isLarge;
//
//   const ECGChart({
//     super.key,
//     this.isLarge = false,
//   });
//
//   @override
//   _ECGChartState createState() => _ECGChartState();
// }
//
// class _ECGChartState extends State<ECGChart> {
//   List<FlSpot> ecgData = [];
//   Timer? timer;
//   double xValue = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     // Inisialisasi data awal
//     initializeData();
//     startDataSimulation();
//   }
//
//   void initializeData() {
//     // Membuat data awal untuk mencegah chart kosong
//     for (double i = 0; i < 10; i += 0.05) {
//       double yValue = generateECGPoint(i);
//       ecgData.add(FlSpot(i, yValue));
//     }
//     xValue = 10;
//   }
//
//   void startDataSimulation() {
//     timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
//       if (mounted) {
//         setState(() {
//           double yValue = generateECGPoint(xValue);
//           ecgData.add(FlSpot(xValue, yValue));
//           // Batasi jumlah data berdasarkan isLarge
//           int maxDataPoints = widget.isLarge ? 200 : 100;
//           if (ecgData.length > maxDataPoints) {
//             ecgData.removeAt(0);
//           }
//           xValue += 0.05;
//         });
//       }
//     });
//   }
//
//   double generateECGPoint(double x) {
//     double base = sin(x * 2);
//     if (x % 2 < 0.2) {
//       return base * 3;
//     }
//     return base;
//   }
//
//   @override
//   void dispose() {
//     timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Tambahkan pengecekan data kosong
//     if (ecgData.isEmpty) {
//       return Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: Colors.white,
//             width: 1,
//           ),
//         ),
//         child: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: Colors.white,
//           width: 1,
//         ),
//       ),
//       padding: const EdgeInsets.all(1),
//       child: LineChart(
//         LineChartData(
//           minX: ecgData.first.x, // Gunakan data point pertama
//           maxX: ecgData.last.x, // Gunakan data point terakhir
//           minY: -3,
//           maxY: 3,
//           gridData: const FlGridData(show: true),
//           titlesData: const FlTitlesData(show: false),
//           borderData: FlBorderData(show: true),
//           lineBarsData: [
//             LineChartBarData(
//               spots: ecgData,
//               isCurved: true,
//               color: Colors.green,
//               dotData: const FlDotData(show: false),
//               belowBarData: BarAreaData(show: false),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
