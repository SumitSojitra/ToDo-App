import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_todo/modules/app/utils/Assets/Assets.dart';
import 'package:my_todo/modules/app/utils/colors/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.kWhite,
      body: Center(
        child: SizedBox(
          child: Image(
            image: AssetImage(AppAssets.logo),
          ),
        ),
      ),
    );
  }
}
