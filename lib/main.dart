import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mello_d/layers/bloc/home/home_bloc.dart';
import 'package:mello_d/layers/presentation/main_screens/home_screen/home_screen.dart';
import 'package:mello_d/layers/presentation/main_screens/library_screen/library_screen.dart';
import 'package:mello_d/layers/presentation/main_screens/search_screen/search_screen.dart';
import 'package:mello_d/layers/styles/app_colors.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MusicBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Mello D',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFF740F)),
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: const MyPersistentTabView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyPersistentTabView extends StatelessWidget {
  const MyPersistentTabView({super.key});

  List<Widget> _buildScreens() {
    return [
      const HomeScreen(),
      SearchScreen(),
      const LibraryScreen(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.grey.withOpacity(0.2),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.search),
        title: ("Settings"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.grey.withOpacity(0.2),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.library_music),
        title: ("Library"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: AppColors.grey.withOpacity(0.2),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: AppColors.white,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 300),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 300),
      ),
      navBarStyle: NavBarStyle.style3,
    );
  }
}
