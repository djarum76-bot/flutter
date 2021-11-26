import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:papa/model/kandangModel.dart';

class EditKandang extends StatefulWidget{
  final VoidCallback reload;
  final KandangModel model;

  const EditKandang({Key? key, required this.reload, required this.model}) : super(key: key);

  @override
  State<EditKandang> createState() => _EditKandangState();
}

class _EditKandangState extends State<EditKandang> {
  late String namaKandang;
  final _key = new GlobalKey<FormState>();
  late TextEditingController txtNamaKandang;

  setup()async{
    txtNamaKandang = TextEditingController(text: widget.model.namaKandang);
  }

  check()async{
    final form = _key.currentState;
    if(form!.validate()){
      form.save();
      submit();
    }
  }

  submit()async{
    final response = await http.post(Uri.parse("http://192.168.100.175/papa/api/editKandang.php"),body: {
      "namaKandang": namaKandang,
      "id": widget.model.id,
    });

    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];

    if(value == 1){
      setState(() {
        widget.reload();
        Navigator.pop(context);
      });
      print(message);
    }else{
      print(message);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
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
                          controller: txtNamaKandang,
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