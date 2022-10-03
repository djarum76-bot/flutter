
import 'package:bloc_ril_api_login/bloc/posts/posts_bloc.dart';
import 'package:bloc_ril_api_login/bloc/posts/posts_event.dart';
import 'package:bloc_ril_api_login/bloc/user/user_bloc.dart';
import 'package:bloc_ril_api_login/cubit/navbar_cubit.dart';
import 'package:bloc_ril_api_login/repositories/post_repository.dart';
import 'package:bloc_ril_api_login/repositories/user_repository.dart';
import 'package:bloc_ril_api_login/screens/home_screen.dart';
import 'package:bloc_ril_api_login/screens/profile_screen.dart';
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
        body: _navbarBody(),
        bottomNavigationBar: _bottomNavBar(),
      ),
    );
  }

  Widget _navbarBody(){
    return RepositoryProvider(
      create: (context) => UserRepository(),
      child: BlocBuilder<NavbarCubit, int>(
        builder: (context, state){
          return IndexedStack(
            index: state,
            children: [
              BlocProvider(
                create: (context) => PostsBloc(postRepository: RepositoryProvider.of<PostRepository>(context))..add(PostsFetched()),
                child: HomeScreen(),
              ),
              BlocProvider(
                create: (context) => UserBloc(userRepository: RepositoryProvider.of<UserRepository>(context))..add(UserFetched()),
                child: ProfileScreen(),
              )
            ],
          );
        },
      ),
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
              icon: Icon(Icons.home_filled),
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