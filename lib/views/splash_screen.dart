import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peanut/service/auth_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800))
      ..forward();
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //--------------------Set timer for route-------------
    Timer(const Duration(milliseconds: 1800), () async {
      await AuthServices().isUserLogin();
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 188, 245, 190),
              Color(0xffC8E6C9),
            ],
          ),
        ),
        alignment: Alignment.center,
        child: ScaleTransition(
          scale: _animation,
          child: Image.asset(
            'assets/images/logo.png',
            width: 500,
            height: 200,
          ),
        ),
      ),
    );
  }
}
