import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: Get.arguments,
      ),
    );
  }
}
