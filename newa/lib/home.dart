import 'package:flutter/material.dart';
import 'package:newa/models/place.dart';
import 'package:newa/register.dart';
import 'package:newa/widgets/home_item.dart';

class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.82,
              child: ListView(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: HomeItem(image: placeList[0].imageAsset, name: placeList[0].name, description: placeList[0].description,),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.186,
                    child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20
                      ),
                      children: [
                        HomeItem(image: placeList[1].imageAsset, name: placeList[1].name, description: placeList[1].description,),
                        HomeItem(image: placeList[2].imageAsset, name: placeList[2].name, description: placeList[2].description,)
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            Expanded(
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute (
                          builder: (BuildContext context) => Register(),
                        )
                    );
                  },
                  child: Text(
                    "Daftar",
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}