import 'package:flutter/material.dart';

class Detail extends StatelessWidget{
  final String description;
  final String image;
  final String name;

  const Detail({Key? key, required this.image, required this.name, required this.description,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.88,
                  child: ListView(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.25,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(image),
                              fit: BoxFit.cover
                          )
                        ),
                      ),
                      Text(
                        name,
                        style: TextStyle(fontSize: 24),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        description,
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Back",
                      ),
                    )
                )
              ],
            ),
          )
      ),
    );
  }
}