import 'dart:typed_data';

class LibDesfire{
  Uint8List desfireSelectApplication(Uint8List bAID){
    final apduClSelectAID = Uint8List.fromList([-112, 90, 0, 0, 3, 0, 0, 0, 0]);
    apduClSelectAID[5] = bAID[2];
    apduClSelectAID[6] = bAID[1];
    apduClSelectAID[7] = bAID[0];
    return apduClSelectAID;
  }

  Uint8List desfireReadData(int bFileNo, int ulOffSet, int ulLength){
    final apduClReadData = Uint8List.fromList([-112, -67, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0]);
    apduClReadData[5] = bFileNo;
    apduClReadData[6] = ulOffSet;
    apduClReadData[7] = ulOffSet >> 8;
    apduClReadData[8] = ulOffSet >> 16;
    apduClReadData[9] = ulLength;
    apduClReadData[10] = ulLength >> 8;
    apduClReadData[11] = ulLength >> 16;
    return apduClReadData;
  }

  Uint8List desfireGetValue(int bFileNo){
    final apduClBalance = Uint8List.fromList([-112, 108, 0, 0, 1, 0, 0]);
    apduClBalance[5] = bFileNo;
    return apduClBalance;
  }
}