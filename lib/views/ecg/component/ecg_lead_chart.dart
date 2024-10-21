// import 'package:flutter/material.dart';
//
// class EcgLeadChart extends StatelessWidget {
//   final List<double> leadData;
//   final String leadName;
//
//   EcgLeadChart({required this.leadData, required this.leadName});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(leadName, style: Tgit xtStyle(fontWeight: FontWeight.bold)),
//         SizedBox(
//           height: 100,
//           child: CustomPaint(
//             painter: EcgPainter(leadData),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// class EcgPainter extends CustomPainter {
//   final List<double> data;
//
//   EcgPainter(this.data);
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = Colors.red
//       ..strokeWidth = 1.5
//       ..style = PaintingStyle.stroke;
//
//     Path path = Path();
//     if (data.isNotEmpty) {
//       double xInterval = size.width / data.length;
//       path.moveTo(0, size.height / 2 - data[0]);
//       for (int i = 1; i < data.length; i++) {
//         path.lineTo(i * xInterval, size.height / 2 - data[i]);
//       }
//     }
//     canvas.drawPath(path, paint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// }


import 'package:flutter/material.dart';

class EcgLeadChart extends StatelessWidget {
  final List<double> leadData;
  final String leadName;

  EcgLeadChart({required this.leadData, required this.leadName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(leadName, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(
          height: 100,
          child: CustomPaint(
            painter: EcgPainter(leadData),
          ),
        ),
      ],
    );
  }
}

class EcgPainter extends CustomPainter {
  final List<double> data;

  EcgPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    Path path = Path();
    if (data.isNotEmpty) {
      double xInterval = size.width / data.length;
      path.moveTo(0, size.height / 2 - data[0]);
      for (int i = 1; i < data.length; i++) {
        path.lineTo(i * xInterval, size.height / 2 - data[i]);
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
