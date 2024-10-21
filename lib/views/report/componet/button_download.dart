import 'package:ble_flutter/theme.dart';
import 'package:ble_flutter/util/dimensions.dart';
import 'package:flutter/material.dart';

class ButtonDownload extends StatelessWidget {
  final String text;
  const ButtonDownload({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 5.5 / 100,
      width: MediaQuery.of(context).size.width * 45 / 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.lightBlueAccent, // Warna awal gradient
            Colors.blue.shade700, // Warna akhir gradient
          ],
          stops: const [0.2, 1.0], // Warna pertama akan mengisi 30% awal
          begin: Alignment.topLeft, // Titik awal gradient
          end: Alignment.bottomRight, // Titik akhir gradient
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: primaryTextStyle3.copyWith(
                  color: Colors.white,
                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
            ),
          ],
        ),
      ),
    );
  }
}
