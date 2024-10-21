import 'package:ble_flutter/theme.dart';
import 'package:ble_flutter/util/dimensions.dart';
import 'package:ble_flutter/util/icons.dart';
import 'package:ble_flutter/views/dashboard/component/button_widget.dart';
import 'package:ble_flutter/views/dashboard/component/device_card.dart';
import 'package:ble_flutter/views/ecg/ecg_screen.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

final List<DeviceList> deviceItems = [
  DeviceList(
    name: "B869H V5.0",
  ),
  DeviceList(
    name: "B869H V6.0",
  ),
  DeviceList(
    name: "B869H V7.0",
  ),
  DeviceList(
    name: "B869H V8.0",
  ),
  DeviceList(
    name: "B869H V9.0",
  ),
];

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        backgroundColor: bg1Color,
        centerTitle: true,
        title: Text(
          "Bluetooth Connection",
          style: primaryTextStyle3.copyWith(
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE),
        ),
      ),
      body: Column(
        children: [
          // Konten bagian atas
          Image.asset(
            Iconss.ble,
            fit: BoxFit.cover,
            height: 300,
            width: 300,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 4.5 / 100,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => EcgScreen(),
                ),
              );
            },
            child: const Button(
              text: "Refresh",
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 4.5 / 100,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(55),
                    topRight: Radius.circular(55)),
                color: Colors.white,
              ),
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Device",
                    style: primaryTextStyle3.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_MID_LARGE),
                  ),
                  Expanded(
                    child: _deviceList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _deviceList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: deviceItems.length,
      itemBuilder: (context, index) {
        DeviceList deviceList = deviceItems[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: DeviceCard(
            name: deviceList.name,
          ),
        );
      },
    );
  }
}
