import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class TambahKandang extends StatefulWidget{
  final VoidCallback reload;

  const TambahKandang({Key? key, required this.reload}) : super(key: key);

  @override
  State<TambahKandang> createState() => _TambahKandangState();
}

class _TambahKandangState extends State<TambahKandang> {
  late String namaKandang;
  final _key = new GlobalKey<FormState>();

  check(){
    final form = _key.currentState;
    if(form!.validate()){
      form.save();
      submit();
    }
  }

  submit()async{
    final response = await http.post(Uri.parse("http://192.168.100.175/papa/api/addKandang.php"),body: {
      "namaKandang" : namaKandang
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];

    if(value == 1){
      setState(() {
        widget.reload();
        Navigator.pop(context);
      });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Kandang"),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.245,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 24),
                child: Form(
                    key: _key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextFormField(
                          validator: (e){
                            if(e!.isEmpty){
                              return "Masukkan Nama Kandang!";
                            }
                          },
                          onSaved: (e) => namaKandang = e!,
                          decoration: InputDecoration(
                              hintText: "Nama Kandang"
                          ),
                        ),
                        SizedBox(height: 25,),
                        ElevatedButton(
                            onPressed: (){
                              check();
                            },
                            child: Text("Tambah",style: TextStyle(fontSize: 16),)
                        ),
                      ],
                    )
                ),
              )
          ),
        ),
      ),
    );
  }
}