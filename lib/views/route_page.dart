import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peanut/views/home_screen.dart';
import 'package:peanut/views/profile_screen.dart';

import 'package:peanut/widget/custom_snackbar.dart';

import '../widget/custom_bottom_tabbar.dart';

// ignore: must_be_immutable
class RoutePage extends StatelessWidget {
  RoutePage({super.key});
  final _selectedIndex = 0.obs;

  List<Widget> page = [
    const HomeScreen(),
    ProfileScreen(),
  ];
  // ---------------Double back button press for closing app-------------
  DateTime? currentBackPressTime;

  Future<bool> _onWillPop(BuildContext context) async {
    
    final now = DateTime.now();

    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      customSnackBar(bgClr: Colors.black, msg: 'Press again close the app');
      return false;
    } else {
      if (Platform.isAndroid) {
        exit(0);
      } else {}
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Obx(
          () => Scaffold(
            body: page[_selectedIndex.value],
            bottomNavigationBar: CustomBottomTabBar(
              index: _selectedIndex.value,
              onChangedTab: onChangedTab,
            ),
          ),
        ));
  }

  void onChangedTab(int index) {
    _selectedIndex(index);
  }
}
