import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class Splash extends StatefulWidget{
  static String tag = 'splash';
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  Database db;
  String dbPath;
  final Color backgroundSplash=const Color(0xffFCDEAC);
  final Color blueLight=const Color(0xff3F51B5);

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/FrontPage');
  }

  void initState(){
    super.initState();
    create_and_Open_DB_and_GetData();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    startTime();
  }

  Future create_and_Open_DB_and_GetData() async {
    Directory path = await getApplicationDocumentsDirectory();
    dbPath = p.join(path.path, "main.db");
    print("db path = $dbPath");
    db = await openDatabase(dbPath, version: 1, onCreate: this.createTable);
  }

  Future createTable(Database db, int version) async {
    await db.execute(
        'CREATE TABLE user(username TEXT, password TEXT)');
    await db.execute(
        'CREATE TABLE test(id TEXT, userid TEXT, title TEXT, body TEXT)');
    //await db.close();
  }

  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'main_logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 150.0,
        child: Image.asset('assets/image/deb_coll_white_copy.png'),
      ),
    );

    final applabel = FlatButton(
      child: Text(
        'SDIT AL MUHAJIRIN',
        style: TextStyle(color: blueLight,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Swiss',
        ),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: backgroundSplash,
      body: Center(
        child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        children: <Widget>[
        logo,
        SizedBox(
          height: 1.0,
          child: new Center(
            child: new Container(
              margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
              height: 1.0,
              color: backgroundSplash,
            ),
          ),
        ),
        SizedBox(height: 1.0),
        applabel,
        SizedBox(height: 170.0),
        ],
        ),
      ),
    );
  }
}