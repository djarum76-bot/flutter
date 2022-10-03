import 'dart:io';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentController extends GetxController {
  //TODO: Implement PaymentController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }
}
