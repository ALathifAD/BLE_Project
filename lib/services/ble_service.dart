// ble_service.dart

class BleService {
  // Fungsi untuk mengkonversi data BLE raw ke format ECG 13 lead
  Map<String, List<double>> extractEcgData(List<int> rawData) {
    // Pastikan data minimal sesuai panjang paket yang diterima
    if (rawData.length < 100) {
      return {};
    }

    // List untuk menyimpan data ECG 13 lead
    Map<String, List<double>> ecgDataMap = {
      "Lead I": [],
      "Lead II": [],
      "Lead III": [],
      "aVR": [],
      "aVL": [],
      "aVF": [],
      "V1": [],
      "V2": [],
      "V3": [],
      "V4": [],
      "V5": [],
      "V6": []
    };

    // Mengambil data dari rawData sesuai dengan urutan lead ECG
    for (int i = 0; i < rawData.length; i += 8) {
      if (i + 7 < rawData.length) {
        // Konversi data integer ke double (simulasi dari Objective-C NSData to ECG data)
        double leadI = _convertToVoltage(rawData[i], rawData[i + 1]);
        double leadII = _convertToVoltage(rawData[i + 2], rawData[i + 3]);
        double leadIII = _convertToVoltage(rawData[i + 4], rawData[i + 5]);

        ecgDataMap["Lead I"]!.add(leadI);
        ecgDataMap["Lead II"]!.add(leadII);
        ecgDataMap["Lead III"]!.add(leadIII);

        // Bisa tambahkan rumus untuk lead lainnya jika diperlukan
        ecgDataMap["aVR"]!.add(leadI);
        ecgDataMap["aVL"]!.add(leadII);
        ecgDataMap["aVF"]!.add(leadIII);
      }
    }
    return ecgDataMap;
  }

  // Fungsi untuk mengonversi raw data ke voltase (simulasi konversi NSData)
  double _convertToVoltage(int byte1, int byte2) {
    int combined = (byte1 << 8) | byte2;
    double voltage = combined * 0.001; // Konversi sesuai dengan skala yang diperlukan
    return voltage;
  }
}











//simulation













// // import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// //
// // class BleService {
// //   // Mendapatkan data ECG dari characteristic
// //   List<int> extractEcgData(List<int> rawData) {
// //     // Misalkan data ECG adalah array dari integer
// //     return rawData; // Anda dapat melakukan pemrosesan sesuai kebutuhan
// //   }
// // }
//
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
//
// class BleService {
//   // Mendapatkan data ECG dari characteristic
//   Map<String, List<double>> extractEcgData(List<int> rawData) {
//     // Asumsikan rawData berisi data mentah yang terbagi ke dalam 13 lead
//     Map<String, List<double>> ecgLeads = {
//       'Lead I': [],
//       'Lead II': [],
//       'Lead III': [],
//       'Lead aVR': [],
//       'Lead aVL': [],
//       'Lead aVF': [],
//       'Lead V1': [],
//       'Lead V2': [],
//       'Lead V3': [],
//       'Lead V4': [],
//       'Lead V5': [],
//       'Lead V6': [],
//       'Lead VI': [],
//     };
//
//     // Misalkan tiap lead memiliki 100 data per sampel (sesuaikan jika berbeda)
//     int leadLength = rawData.length ~/ 13;
//
//     // Mengisi data untuk masing-masing lead
//     ecgLeads['Lead I'] = _convertToDoubleList(rawData.sublist(0, leadLength));
//     ecgLeads['Lead II'] = _convertToDoubleList(rawData.sublist(leadLength, leadLength * 2));
//     ecgLeads['Lead III'] = _convertToDoubleList(rawData.sublist(leadLength * 2, leadLength * 3));
//     ecgLeads['Lead aVR'] = _convertToDoubleList(rawData.sublist(leadLength * 3, leadLength * 4));
//     ecgLeads['Lead aVL'] = _convertToDoubleList(rawData.sublist(leadLength * 4, leadLength * 5));
//     ecgLeads['Lead aVF'] = _convertToDoubleList(rawData.sublist(leadLength * 5, leadLength * 6));
//     ecgLeads['Lead V1'] = _convertToDoubleList(rawData.sublist(leadLength * 6, leadLength * 7));
//     ecgLeads['Lead V2'] = _convertToDoubleList(rawData.sublist(leadLength * 7, leadLength * 8));
//     ecgLeads['Lead V3'] = _convertToDoubleList(rawData.sublist(leadLength * 8, leadLength * 9));
//     ecgLeads['Lead V4'] = _convertToDoubleList(rawData.sublist(leadLength * 9, leadLength * 10));
//     ecgLeads['Lead V5'] = _convertToDoubleList(rawData.sublist(leadLength * 10, leadLength * 11));
//     ecgLeads['Lead V6'] = _convertToDoubleList(rawData.sublist(leadLength * 11, leadLength * 12));
//     ecgLeads['Lead VI'] = _convertToDoubleList(rawData.sublist(leadLength * 12, rawData.length));
//
//     return ecgLeads;
//   }
//
//   List<double> _convertToDoubleList(List<int> data) {
//     return data.map((e) => e.toDouble()).toList();
//   }
// }
