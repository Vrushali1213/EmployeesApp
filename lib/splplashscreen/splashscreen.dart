import 'dart:async';
import 'package:employeeinformation/widget/custom_color.dart';
import 'package:employeeinformation/widget/size_config.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double? scrWidth, scrHeight;

  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  initPreferences() async {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, '/EmployeeList', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    scrWidth = MediaQuery.of(context).size.width;
    scrHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: CustomColor.white,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splash.png"),
              fit: BoxFit.cover,
            ),
          ),
        ));
  }
}
