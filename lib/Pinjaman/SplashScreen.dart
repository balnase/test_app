import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_app/Pinjaman/TextUtil.dart' as Utils;
import 'package:test_app/Pinjaman/Widgets/SplashWidgets.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:test_app/Pinjaman/HomeState.dart';

class SplashScreen extends StatefulWidget{

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
      //Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>new HomeState()));
      Navigator.of(context).pushReplacementNamed('/HomeState');
  }

  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    startTime();
  }

  final applabel = FlatButton(
    child: Text(
      Utils.textStr.appTitle,
      style: TextStyle(color : Utils.Colors.holo_red_dark,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Swiss',
      ),
    ),
    onPressed: () {},
  );

  final appDev = FlatButton(
    child: Text(
      Utils.textStr.appDevTitle,
      style: TextStyle(color : Utils.Colors.holo_red_dark,
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        fontFamily: 'Swiss',
      ),
    ),
    onPressed: () {},
  );

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Utils.Colors.startColor,
      body: Center(
        child: Column(
          //shrinkWrap: true,
          //padding: EdgeInsets.only(left: 10.0, right: 10.0),
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(child: Container()),
            Expanded(child: SplashWidgets()),
            SizedBox(height: 15.0),
            new Container(
              height: 1.5,
              width: 250.0,
              color: Utils.Colors.holo_red_dark,
            ),
            applabel,
            Expanded(child: Container()),
            appDev,
          ],
        ),
      ),
    );
  }
}