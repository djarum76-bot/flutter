import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:nfc_manager/platform_tags.dart';

class LibBNI{
  final _resultOK = 36864;

  int _resultCode(Uint8List result, int len) {
    return (result[len - 2].toInt() << 8) + result[len - 1];
  }

  Future<int> isoIsMyCard(IsoDep isoDep, Uint8List cardNo, Uint8List purseData) async {
    final apduClSelectApp = Uint8List.fromList([0, -92, 4, 0, 8, -96, 0, 66, 78, 73, 16, 0, 1]);
    final cmdPurse = Uint8List.fromList([0, -124, 0, 0, 8]);
    final cmdSecure = Uint8List.fromList([-112, 50, 3, 0, 10, 18, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0]);
    final crn = Uint8List(8);
    var rrn = Uint8List(8);

    try {
      var respData = await isoDep.transceive(data: apduClSelectApp);
      if (_resultCode(respData, respData.length) != _resultOK) {
        return -1;
      }

      respData = await isoDep.transceive(data: cmdPurse);
      if (_resultCode(respData, respData.length) != _resultOK) {
        return -1;
      }
      crn.setAll(0, respData.sublist(0, crn.length));
      final random = Random.secure();
      rrn = Uint8List.fromList(List<int>.generate(8, (_) => random.nextInt(256)));
      cmdSecure.setRange(7, 7 + rrn.length, rrn);

      respData = await isoDep.transceive(data: cmdSecure);
      if (_resultCode(respData, respData.length) != _resultOK) {
        return -1;
      }
      try {
        cardNo.setAll(0, respData.sublist(16, 16 + 8));
      } catch (ex) {
        if (kDebugMode) {
          print(ex);
        }
        return -1;
      }
      try {
        purseData.setAll(0, respData.sublist(0, respData.length - 2));
        return 0;
      } catch (ex) {
        if (kDebugMode) {
          print(ex);
        }
        return -1;
      }
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      return -1;
    }
  }

  int isoGetFastBalance(Uint8List purseData, List<int> balance) {
    balance[0] = (purseData[2] << 16) + (purseData[3] << 8) + purseData[4];
    return 0;
  }
}