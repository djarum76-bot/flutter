import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import 'screens.dart';

class InteractiveExample extends StatefulWidget {
  @override
  State<InteractiveExample> createState() => _InteractiveExampleState();
}

class _InteractiveExampleState extends State<InteractiveExample> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  List<Widget> _buildScreens() {
    return [
      MainScreen(),
      MainScreen(),
      MainScreen(),
      MainScreen(),
      MainScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => MainScreen2(),
            '/second': (context) => MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.add),
          title: ("Add"),
          activeColorPrimary: Colors.blueAccent,
          activeColorSecondary: Colors.white,
          inactiveColorPrimary: Colors.white,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: '/',
            routes: {
              '/first': (context) => MainScreen2(),
              '/second': (context) => MainScreen3(),
            },
          ),
          onPressed: (context) {
          }),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        title: ("Messages"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => MainScreen2(),
            '/second': (context) => MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => MainScreen2(),
            '/second': (context) => MainScreen3(),
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navigation Bar Demo')),
      drawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            ],
          ),
        ),
      ),
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        navBarHeight: kBottomNavigationBarHeight,
        hideNavigationBarWhenKeyboardShows: true,
        margin: EdgeInsets.zero,
        popActionScreens: PopActionScreensType.all,
        bottomScreenMargin: 0.0,
        onWillPop: (context) async {
          await showDialog(
            context: context!,
            useSafeArea: true,
            builder: (context) => Container(
              height: 50.0,
              width: 50.0,
              color: Colors.white,
              child: ElevatedButton(
                child: Text("Close"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          );
          return false;
        },
        hideNavigationBar: false,
        decoration: NavBarDecoration(
          colorBehindNavBar: Colors.indigo,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: ItemAnimationProperties(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style15,
      ),
    );
  }
}