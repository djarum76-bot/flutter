import 'package:flutter/material.dart';
import 'package:newa/home.dart';

class Login extends StatefulWidget{
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final key = GlobalKey<FormState>();

  bool secure = true;

  Future<void> check(BuildContext context)async {
    final form = key.currentState;
    if (form!.validate()) {
      form.save();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Home()
          )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
            key: key,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: "Username",
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
                      return "Username tidak boleh kosong";
                    }
                  },
                ),
                TextFormField(
                  obscureText: secure,
                  decoration: InputDecoration(
                    hintText: "Password",
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
                      Icons.lock,
                      color: Color(0xFF2D2424),
                    ),
                    prefixIconColor: Color(0xFF2D2424),
                    suffixIcon: IconButton(
                      icon: Icon(secure ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          secure = !secure;
                        });
                      },
                    ),
                  ),
                  validator: (a){
                    if(a!.isEmpty){
                      return "Password tidak boleh kosong";
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
                    "Login",
                  ),
                )
              ],
            )
        ),
      ),
    );
  }
}