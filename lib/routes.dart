import 'package:flutter/material.dart';
import 'Splash.dart';
import 'home_page.dart';
import 'FrontPage.dart';
import 'package:test_app/SignUpPage.dart';
import 'package:test_app/SignInPage.dart';
import 'package:test_app/DashboardMenu.dart';
import 'package:test_app/Pinjaman/HomeState.dart';

final routes = {
  '/Splash':         (BuildContext context) => new Splash(),
  '/home_page':         (BuildContext context) => new HomePage(),
  '/FrontPage':         (BuildContext context) => new FrontPage(),
  //'/SignUpPage':         (BuildContext context) => new SignUpPage(),
  '/SignInPage':         (BuildContext context) => new SignInPage(),
  '/DashboardMenu':         (BuildContext context) => new DashboardMenu(),
  '/HomeState':         (BuildContext context) => new HomeState(),
};