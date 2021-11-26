import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:papa/kandang/detail_kandang.dart';
import 'package:papa/kandang/edit_kandang.dart';
import 'package:papa/kandang/tambah_kandang.dart';
import 'package:http/http.dart' as http;
import 'package:papa/model/kandangModel.dart';

class HomeKandang extends StatefulWidget{
  @override
  State<HomeKandang> createState() => _HomeKandangState();
}

class _HomeKandangState extends State<HomeKandang> {
  var loading = false;

  final list = <KandangModel>[];
  final GlobalKey<RefreshIndicatorState> _refresh = GlobalKey<RefreshIndicatorState>();

  Future<void>_lihatData()async{
    list.clear();
    setState(() {
      loading = true;
    });

    final response = await http.get(Uri.parse("http://192.168.100.175/papa/api/lihatKandang.php"));

    if(response.contentLength == 2){

    }else{
      final data = jsonDecode(response.body);
      data.forEach((api){
        final ab = new KandangModel(
            id: api['id'],
            namaKandang: api['namaKandang']
        );
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  _delete(String id)async{
    final response = await http.post(Uri.parse("http://192.168.100.175/papa/api/deleteKandang.php"),body: {
      "id": id
    });

    final data = jsonDecode(response.body);

    int value = data['value'];
    String message = data['message'];

    if(value == 1){
      setState(() {
        _lihatData();
      });
    }else{
      print(message);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lihatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TELUR"),
      ),
      body: RefreshIndicator(
        child: loading
            ? Center(child: CircularProgressIndicator(),)
            : ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index){
              final x = list[index];
              return Padding(
                padding: EdgeInsets.only(top: 8,left: 8,right: 8),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return DetailKandang(model: x);
                    }));
                  },
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        margin: EdgeInsets.all(8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(x.namaKandang,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                            ),
                            IconButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return EditKandang(reload: _lihatData, model: x);
                                  }));
                                },
                                icon: Icon(Icons.edit)
                            ),
                            IconButton(
                                onPressed: (){
                                  showDialog(
                                    context: context,
                                    // false = user must tap button, true = tap outside dialog
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('WARNING!!!'),
                                        content: Text('Are you sure you want to delete this product ?'),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text('No'),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                          TextButton(
                                              onPressed: (){
                                                _delete(x.id);
                                                Navigator.pop(context);
                                              },
                                              child: Text("Yes")
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                icon: Icon(Icons.delete)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              );
            }
        ),
        onRefresh: _lihatData,
        key: _refresh,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (counter){
              return TambahKandang(reload: _lihatData,);
            }));
          },
          child: Icon(Icons.add),
      ),
    );
  }
}