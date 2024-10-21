import 'package:ble_flutter/theme.dart';
import 'package:flutter/material.dart';

class ListPoint extends StatelessWidget {
  final String name;
  final String value;
  final String type;
  const ListPoint({
    super.key,
    required this.name,
    required this.value,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          style: primaryTextStyle2.copyWith(
              color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: primaryTextStyle2.copyWith(
              color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        Text(
          type,
          style: primaryTextStyle2.copyWith(
              color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
