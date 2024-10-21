import 'package:ble_flutter/theme.dart';
import 'package:ble_flutter/util/dimensions.dart';
import 'package:ble_flutter/util/images.dart';
import 'package:ble_flutter/views/report/componet/button_download.dart';
import 'package:ble_flutter/views/report/componet/list_point.dart';
import 'package:flutter/material.dart';

class EmbossedDiagonalPattern extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint untuk garis gelap (bagian bawah - memberi efek bayangan)
    final darkPaint = Paint()
      ..color = Colors.black87.withOpacity(0.1)
      ..strokeWidth = 0.1
      ..style = PaintingStyle.stroke;

    // Paint untuk garis terang (bagian atas - memberi efek highlight)
    final lightPaint = Paint()
      ..color = Colors.black45.withOpacity(0.3)
      ..strokeWidth = 0.2
      ..style = PaintingStyle.stroke;

    double gap = 60; // Jarak antar garis

    // Menggambar pola garis diagonal dengan efek emboss
    for (double i = -size.height; i < size.width + size.height; i += gap) {
      // Garis gelap (sedikit bergeser ke kanan dan bawah)
      canvas.drawLine(
        Offset(i + 1.5, 1.5),
        Offset(i + size.height + 1.5, size.height + 1.5),
        darkPaint,
      );

      // Garis terang
      canvas.drawLine(
        Offset(i, 0),
        Offset(i + size.height, size.height),
        lightPaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient dengan pattern emboss
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [
                  Color.fromARGB(255, 103, 182, 247), // Biru cerah
                  Color.fromARGB(255, 31, 110, 190), // Biru lebih gelap
                ],
              ),
            ),
            child: CustomPaint(
              painter: EmbossedDiagonalPattern(),
              size: Size.infinite,
              child: Container(),
            ),
          ),
          // Content
          SafeArea(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        '[230209001000003]',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: bg1Color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 35,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Center(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black
                                            .withOpacity(0.2), // Warna bayangan
                                        spreadRadius: 4, // Penyebaran bayangan
                                        blurRadius: 5, // Radius blur
                                        offset: const Offset(
                                            0, 3), // Posisi bayangan (x,y)
                                      ),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Id Device : ECG Pro 600",
                                            style: primaryTextStyle3.copyWith(
                                              color: Colors.grey,
                                              fontSize:
                                              Dimensions.FONT_SIZE_LARGE,
                                            ),
                                          ),
                                          Text(
                                            "Date : 03-04-2021",
                                            style: primaryTextStyle3.copyWith(
                                              color: Colors.grey,
                                              fontSize:
                                              Dimensions.FONT_SIZE_LARGE,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "ST Junction (J) and Segment Deptession; Posterior (inferior) site;",
                                            style: primaryTextStyle2.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                            ),
                                          ),
                                          Text(
                                            "T-Wave Items; Amterior site;",
                                            style: primaryTextStyle2.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                            ),
                                          ),
                                          Text(
                                            "T-Wave Items; Posterior (inferior) site;",
                                            style: primaryTextStyle2.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                            ),
                                          ),
                                          Text(
                                            "T-Wave Items; Anterolateral site;",
                                            style: primaryTextStyle2.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                            ),
                                          ),
                                          Text(
                                            "Ventciluar Conduction Defect;; Intermittent left bundle branch block",
                                            style: primaryTextStyle2.copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize:
                                              Dimensions.FONT_SIZE_DEFAULT,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  ListPoint(
                                                    name: 'HR: ',
                                                    value: '75',
                                                    type: 'rmbp',
                                                  ),
                                                  ListPoint(
                                                    name: 'RR: ',
                                                    value: '761',
                                                    type: 'ms',
                                                  ),
                                                  ListPoint(
                                                    name: 'PR: ',
                                                    value: '136',
                                                    type: 'ms',
                                                  ),
                                                  ListPoint(
                                                    name: 'QRS: ',
                                                    value: '88',
                                                    type: 'ms',
                                                  ),
                                                  ListPoint(
                                                    name: 'Pd: ',
                                                    value: '88',
                                                    type: 'ms',
                                                  ),
                                                  ListPoint(
                                                    name: 'QT: ',
                                                    value: '328',
                                                    type: 'ms',
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  ListPoint(
                                                    name: 'Qtc: ',
                                                    value: '376',
                                                    type: 'ms',
                                                  ),
                                                  ListPoint(
                                                    name: 'Qtd: ',
                                                    value: '48',
                                                    type: 'ms',
                                                  ),
                                                  ListPoint(
                                                    name: 'QTmax(v1): ',
                                                    value: '284',
                                                    type: 'ms',
                                                  ),
                                                  ListPoint(
                                                    name: 'QTmin(v1): ',
                                                    value: '326',
                                                    type: 'ms',
                                                  ),
                                                  ListPoint(
                                                    name: 'Paxis: ',
                                                    value: '2',
                                                    type: '',
                                                  ),
                                                  ListPoint(
                                                    name: 'QRSaxis: ',
                                                    value: '2',
                                                    type: '',
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  ListPoint(
                                                    name: 'Taxis: ',
                                                    value: '10',
                                                    type: '',
                                                  ),
                                                  ListPoint(
                                                    name: 'SV1: ',
                                                    value: '0,00',
                                                    type: 'mV',
                                                  ),
                                                  ListPoint(
                                                    name: 'RV1: ',
                                                    value: '0,02',
                                                    type: 'mV',
                                                  ),
                                                  ListPoint(
                                                    name: 'SV5: ',
                                                    value: '0,08',
                                                    type: 'mV',
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10),
                                child: Image.asset(Images.dummystat),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const ButtonDownload(
                              text: "Download Data",
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  4.5 /
                                  100,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
