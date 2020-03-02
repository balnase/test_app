import 'package:flutter/material.dart';
import 'home_page.dart';
import 'routes.dart';
import 'test2.dart';
import 'info.dart';
import 'Splash.dart';
import 'package:test_app/FrontPage.dart';
import 'package:test_app/Pinjaman/SplashScreen.dart';
import 'package:test_app/Pinjaman/HomeState.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Test App",
      theme: new ThemeData(primarySwatch: Colors.red),
      home: new SplashScreen(),
      routes: routes,
    );
  }
}