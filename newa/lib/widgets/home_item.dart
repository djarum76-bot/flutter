import 'package:flutter/material.dart';
import 'package:newa/detail.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    Key? key, required this.image, required this.name, required this.description,
  }) : super(key: key);

  final String image;
  final String name;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute (
              builder: (BuildContext context) => Detail(image: image, name: name, description: description),
            )
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover
                )
            ),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                      name
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}