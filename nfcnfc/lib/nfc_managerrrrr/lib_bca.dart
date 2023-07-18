import 'package:flutter/foundation.dart';
import 'package:nfc_manager/platform_tags.dart';

class LibBCA{
  final int _resultOK = 36864;
  int _curBalance = 0;

  int _resultCode(Uint8List result, int len) {
    return (result[len - 2].toInt() << 8) + result[len - 1];
  }

  Future<int> isoIsMyCard(IsoDep isoDep, Uint8List cardNo, Uint8List cardInfo) async {
    final apduClSelectApp = Uint8List.fromList([0, -92, 4, 0, 11, -96, 0, 0, 0, 24, 15, 0, 0, 1, -128, 1]);
    final apduClFastSelectFile = Uint8List.fromList([0, -92, 1, 0, 2, 2, 0]);
    final apduClFastGetBalance = Uint8List.fromList([-128, 50, 0, 3, 4, 0, 0, 0, 0]);
    final apduClFastGetInfo = Uint8List.fromList([0, -80, -127, 0, -114]);

    try {
      var respData = await isoDep.transceive(data: apduClSelectApp);
      if (_resultCode(respData, respData.length) != _resultOK) {
        return -1;
      }

      respData = await isoDep.transceive(data: apduClFastSelectFile);
      if (_resultCode(respData, respData.length) != _resultOK) {
        return -1;
      }

      respData = await isoDep.transceive(data: apduClFastGetBalance);
      if (_resultCode(respData, respData.length) != _resultOK) {
        return -1;
      }

      _curBalance = (respData[1].toInt() << 16) + (respData[2] << 8) + respData[3];

      respData = await isoDep.transceive(data: apduClFastGetInfo);
      if (_resultCode(respData, respData.length) != _resultOK) {
        return -1;
      }

      cardNo.setRange(0, 16, respData, 104);
      cardInfo.setRange(0, respData.length - 2, respData, 0);
      return 0;
    } catch (ex) {
      if (kDebugMode) {
        print(ex);
      }
      return -1;
    }
  }

  int isoGetFastBalance(List<int> balance) {
    balance[0] = _curBalance;
    return 0;
  }
}