import 'package:flutter/material.dart';
import 'package:papa/model/kandangModel.dart';

class DetailKandang extends StatelessWidget{
  final KandangModel model;

  const DetailKandang({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${model.namaKandang}"),
      ),
    );
  }
}