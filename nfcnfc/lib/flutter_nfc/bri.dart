import 'package:flutter/foundation.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:nfcnfc/nfc_managerrrrr/lib_desfire.dart';

class LibBRI{
  int _resultCode(Uint8List result, int len){
    return result[len - 1].toInt();
  }

  Future<int> isoIsMyCard(IsoDep isoDep, Uint8List cardNo, Uint8List cardInfo) async {
    final bAID = Uint8List.fromList([0, 0, 1]);
    try{
      var apdu = LibDesfire().desfireSelectApplication(bAID);
      var respData = await isoDep.transceive(data: apdu);
      if (_resultCode(respData, respData.length) != 0) {
        return -1;
      }

      apdu = LibDesfire().desfireReadData(0, 3, 13);
      respData = await isoDep.transceive(data: apdu);
      if (_resultCode(respData, respData.length) != 0) {
        return -1;
      }

      cardNo.setRange(0, 8, respData.sublist(0, 8));
      cardInfo.setRange(0, 13, respData);

      apdu = LibDesfire().desfireReadData(1, 0, 5);
      respData = await isoDep.transceive(data: apdu);
      if (_resultCode(respData, respData.length) != 0 || respData[3] != 97) {
        return -1;
      }

      if (respData[4] != 97) {
        return -1;
      }

      return 0;
    }catch(ex){
      if(kDebugMode){
        print(ex);
      }
      return -1;
    }
  }

  Future<int> isoGetFastBalance(IsoDep isoDep, List<int> balance) async {
    final bAID = Uint8List.fromList([0, 0, 3]);
    try{
      var apdu = LibDesfire().desfireSelectApplication(bAID);
      var respData = await isoDep.transceive(data: apdu);
      if(_resultCode(respData, respData.length) != 0){
        return -1;
      }

      apdu = LibDesfire().desfireGetValue(0);
      respData = await isoDep.transceive(data: apdu);
      if(_resultCode(respData, respData.length) != 0){
        return -1;
      }

      balance[0] = respData[0] + (respData[1].toInt() << 8) + (respData[2].toInt() << 16) + (respData[3].toInt() << 24);
      return 0;
    }catch(e){
      if(kDebugMode){
        print(e);
      }
      return -1;
    }
  }
}