import 'package:bloc_api_login/cubit/navbar.dart';
import 'package:bloc_api_login/screens/home_screen.dart';
import 'package:bloc_api_login/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavbarScreen extends StatelessWidget{
  const NavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => NavbarCubit(),
        child: Scaffold(
          body: _bodyNavbar(),
          bottomNavigationBar: _bottomNavBar(),
        ),
    );
  }

  Widget _bodyNavbar(){
    return BlocBuilder<NavbarCubit, int>(
      builder: (context, state){
        return IndexedStack(
          index: state,
          children: [
            HomeScreen(),
            ProfileScreen()
          ],
        );
      },
    );
  }

  Widget _bottomNavBar(){
    return BlocBuilder<NavbarCubit, int>(
      builder: (context, state){
        return SalomonBottomBar(
          currentIndex: state,
          onTap: context.read<NavbarCubit>().changeTab,
          items: [
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text("Home"),
              selectedColor: Colors.purple,
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.teal,
            ),
          ],
        );
      },
    );
  }
}