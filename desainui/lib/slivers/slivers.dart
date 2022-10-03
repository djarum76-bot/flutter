import 'package:desainui/slivers/strings.dart';
import 'package:flutter/material.dart';

class Slivers extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (context, isScrolled){
            return [
              SliverAppBar(
                pinned: true,
                expandedHeight: 200,
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                      'assets/pixel_google.jpg',
                      fit: BoxFit.fitWidth,
                  ),
                  title: Text("Google Pixel"),
                  titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                ),
              )
            ];
          },
          body: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            r'$735',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Container(
                            color: Colors.black26,
                            padding: EdgeInsets.all(8),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.collections,
                                  color: Colors.white,
                                ),
                                Text(
                                  '6 photos',
                                  style: TextStyle(color: Colors.white),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 8,),
                      Text(
                        'Stock hanya 5 buah',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      SizedBox(height: 8,),
                      Text(content_text),
                      SizedBox(height: 8,),
                      Text(
                        'Spesifikasi',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(height: 8,),
                      Table(
                        columnWidths: {1: FractionColumnWidth(0.7)},
                        children: [
                          TableRow(
                            children: [
                              Text('Display'),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Text(content_specs_display),
                              )
                            ]
                          ),
                          TableRow(
                            children: [
                              Text('Size'),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Text(content_specs_size),
                              )
                            ]
                          ),
                          TableRow(
                            children: [
                              Text('Battery'),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Text(content_specs_battery),
                              )
                            ]
                          )
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Dijual oleh',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.all(8),
                              child: CircleAvatar(
                                backgroundImage: AssetImage('assets/photo_2.jpg'),
                                radius: 24,
                              ),
                          ),
                          Text('Narenda Wicaksono')
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: (){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text("Added to cart")
                                )
                              );
                            },
                            child: Text("Beli"),
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              onPrimary: Colors.white,
                              shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8)
                                )
                              )
                            ),
                        ),
                      )
                    ],
                  ),
              )
            ],
          )
      ),
    );
  }
}