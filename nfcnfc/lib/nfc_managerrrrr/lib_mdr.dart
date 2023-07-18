
import 'package:flutter/foundation.dart';
import 'package:nfc_manager/platform_tags.dart';

class LibMDR{
  final _resultOK = 36864;

  int _resultCode(Uint8List result, int len){
    return (result[len - 2].toInt() << 8) + result[len - 1];
  }

  Future<int> isoIsMyCard(IsoDep isoDep, Uint8List cardNo, Uint8List cardInfo)async{
    final apduClSelectApp = Uint8List.fromList([0, -92, 4, 0, 8, 0, 0, 0, 0, 0, 0, 0, 1]);
    final apduClCardInfo = Uint8List.fromList([0, -77, 0, 0, 63]);
    var respData = await isoDep.transceive(data: apduClSelectApp);
    if (_resultCode(respData, respData.length) != _resultOK) {
      return -1;
    }

    respData = await isoDep.transceive(data: apduClCardInfo);
    if (_resultCode(respData, respData.length) != _resultOK) {
      return -1;
    }

    cardNo.setRange(0, 8, respData);
    cardInfo.setRange(0, respData.length - 2, respData);
    return 0;
  }

  Future<int> isoGetFastBalance(IsoDep isoDep, List<int> balance) async {
    Uint8List apduClFastGetBalance = Uint8List.fromList([0, -75, 0, 0, 10]);

    try {
      Uint8List respData = await isoDep.transceive(data: apduClFastGetBalance);
      if (_resultCode(respData, respData.length) != _resultOK) {
        return -1;
      }

      balance[0] = ((respData[3] & 0xff) << 24) |
      ((respData[2] & 0xff) << 16) |
      ((respData[1] & 0xff) << 8) |
      (respData[0] & 0xff);
      return 0;
    } catch (ex) {
      if (kDebugMode) {
        print(ex.toString());
      }
      return -1;
    }
  }
}