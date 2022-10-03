import 'package:flutter/material.dart';

class Register extends StatefulWidget{
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final key = GlobalKey<FormState>();

  Future<void> check(BuildContext context)async {
    final form = key.currentState;
    if (form!.validate()) {
      form.save();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
            key: key,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Nama",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Color(0xFF2D2424)
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xFF2D2424)
                          )
                      ),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Color(0xFF2D2424),
                      ),
                      prefixIconColor: Color(0xFF2D2424)
                  ),
                  validator: (a){
                    if(a!.isEmpty){
                      return "Nama tidak boleh kosong";
                    }
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: "No. Telp",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF2D2424)
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Color(0xFF2D2424)
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.numbers,
                      color: Color(0xFF2D2424),
                    ),
                    prefixIconColor: Color(0xFF2D2424),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (a){
                    if(a!.isEmpty){
                      return "No Telp tidak boleh kosong";
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: (){
                    check(context);
                  },
                  child: Text(
                    "Simpan",
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}