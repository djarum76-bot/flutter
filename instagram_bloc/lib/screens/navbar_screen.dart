
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram_bloc/cubit/navbar_cubit.dart';
import 'package:instagram_bloc/screens/home_screen.dart';
import 'package:instagram_bloc/screens/profile_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class NavbarScreen extends StatelessWidget{
  const NavbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavbarCubit(),
      child: Scaffold(
        body: _navbarBody(),
        bottomNavigationBar: _bottomNavBar(),
      ),
    );
  }

  Widget _navbarBody(){
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
              selectedColor: Colors.teal
            ),
            SalomonBottomBarItem(
                icon: Icon(Icons.person),
                title: Text("User"),
                selectedColor: Colors.purple
            )
          ],
        );
      },
    );
  }
}