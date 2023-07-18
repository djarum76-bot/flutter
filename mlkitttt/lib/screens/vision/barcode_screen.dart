import 'package:flutter/material.dart';

class BarcodeScreen extends StatelessWidget{
  const BarcodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _barcodeAppBar(),
    );
  }

  AppBar _barcodeAppBar(){
    return AppBar(
      title: const Text("Barcode Scanning"),
    );
  }
}