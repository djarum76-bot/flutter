import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nonolep/cubit/dashboard_cubit.dart';
import 'package:nonolep/screens/dashboard/discover_screen.dart';
import 'package:nonolep/screens/dashboard/home_screen.dart';
import 'package:nonolep/screens/dashboard/insight_screen.dart';
import 'package:nonolep/screens/dashboard/profile_screen.dart';
import 'package:nonolep/utils/app_theme.dart';

class DashboardScreen extends StatelessWidget{
  DashboardScreen({super.key});

  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const DiscoverScreen(),
    const InsightScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: Scaffold(
        body: _dashboardBody(context),
        bottomNavigationBar: _dashboardNavigationBar(context),
      ),
    );
  }

  Widget _dashboardBody(BuildContext context){
    return BlocBuilder<DashboardCubit, int>(
      builder: (context, state){
        return SafeArea(
          child: Center(
            child: _pages[state],
          ),
        );
      },
    );
  }

  Widget _dashboardNavigationBar(BuildContext context){
    return BlocBuilder<DashboardCubit, int>(
      builder: (context, state){
        return CustomNavigationBar(
          selectedColor: AppTheme.primaryColor,
          strokeColor: AppTheme.primaryColor,
          unSelectedColor: AppTheme.greyIconColor,
          backgroundColor: AppTheme.onScaffoldColor,
          items: [
            CustomNavigationBarItem(icon: const Icon(LineIcons.home)),
            CustomNavigationBarItem(icon: const Icon(LineIcons.compass)),
            CustomNavigationBarItem(icon: const Icon(LineIcons.barChartAlt)),
            CustomNavigationBarItem(icon: const Icon(LineIcons.user)),
          ],
          currentIndex: state,
          onTap: context.read<DashboardCubit>().changePage,
        );
      },
    );
  }
}