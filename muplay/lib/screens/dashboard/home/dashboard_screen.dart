import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:muplay/cubit/dashboard_cubit.dart';
import 'package:muplay/screens/dashboard/home_screen.dart';
import 'package:muplay/screens/dashboard/playlists_screen.dart';
import 'package:muplay/utils/app_theme.dart';

class DashboardScreen extends StatelessWidget{
  DashboardScreen({super.key});

  final List<Widget> _pages = [
    const HomeScreen(),
    const PlaylistsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: Scaffold(
        body: _dashboardBody(),
        bottomNavigationBar: _dashboardNavBar(context),
      ),
    );
  }

  Widget _dashboardBody(){
    return BlocBuilder<DashboardCubit, int>(
      builder: (context, state){
        return Center(
          child: _pages[state],
        );
      },
    );
  }

  Widget _dashboardNavBar(BuildContext context){
    return BlocBuilder<DashboardCubit, int>(
      builder: (context, state){
        return CustomNavigationBar(
          selectedColor: AppTheme.primaryColor,
          strokeColor: Colors.white,
          unSelectedColor: AppTheme.greyColor,
          backgroundColor: Colors.white,
          items: [
            CustomNavigationBarItem(
              icon: const Icon(LineIcons.home)
            ),
            CustomNavigationBarItem(
              icon: const Icon(LineIcons.bookOpen)
            )
          ],
          currentIndex: state,
          onTap: context.read<DashboardCubit>().changeTab,
        );
      },
    );
  }
}