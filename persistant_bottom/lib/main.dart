import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistant_bottom/interactive_example.dart';
import 'package:persistant_bottom/screens.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

void main() => runApp(PersistenBottomNavBarDemo());

class PersistenBottomNavBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Persistent Bottom Navigation Bar Demo',
      home: MainMenu(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/first': (context) => MainScreen2(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => MainScreen3(),
      },
    );
  }
}

class MainMenu extends StatefulWidget {
  MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigation Bar Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20.0),
          Center(
            child: ElevatedButton(
              child: Text("Interactive Example"),
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (BuildContext context) {
                    return InteractiveExample();
                  },
                ),
                    (_) => false,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
