import 'package:employeeinformation/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widget/custom_color.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TimerApp',
        theme: ThemeData(
          primaryColor: CustomColor.grey,
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routes: Routes.generateRoute(),
        initialRoute: '/SplashScreen');
  }
}
