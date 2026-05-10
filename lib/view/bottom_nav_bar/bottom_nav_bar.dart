import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:hospital_q/view/history/history_screen.dart';
import 'package:hospital_q/view/home/home_screen.dart';
import 'package:hospital_q/view/profile/update_profile_screen.dart';
import 'package:hospital_q/view/token/token_screen.dart';

import '../../resources/app_color.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 2;

  final screens = [
    HomeScreen(),
    TokenScreen(),
    HistoryScreen(),
    UpdateProfileScreen(),

  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Icon(Icons.home, size: 30),
      Icon(Icons.local_activity, size: 30),
      Icon(Icons.access_time, size: 30),
      Icon(Icons.person, size: 30),
    ];
    return Scaffold(
      body: screens[index],
      extendBody: true,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(
            color: AppColor.primary
          ),
        ),
        child: CurvedNavigationBar(
          key: navigationKey,
          color: Colors.lightBlueAccent.shade200,
          buttonBackgroundColor:Colors.grey.shade200,
          backgroundColor: Colors.transparent,
          height: 55,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 350),
          items: items,
          index: index,
          onTap: (index)=> setState(() {
            this.index = index;
          })
        ),
      ),
    );
  }
}
