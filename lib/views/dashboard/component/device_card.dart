import 'package:ble_flutter/theme.dart';
import 'package:flutter/material.dart';

class DeviceList {
  final String name;

  DeviceList({
    required this.name,
  });
}

class DeviceCard extends StatelessWidget {
  final String name;
  const DeviceCard({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 10 / 100,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: bg1Color,
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 25),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.bluetooth),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: primaryTextStyle3,
                    ),
                    Text(
                      "connect",
                      style: primaryTextStyle2.copyWith(color: Colors.grey),
                    ),
                  ],
                )
              ],
            ),
            CircleAvatar(
              backgroundColor: Colors.grey.shade300,
              radius: 10,
              child: Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.grey.shade600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
