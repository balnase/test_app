import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/Theme.dart' as Theme;
import 'package:sqflite/sqflite.dart';
import 'package:test_app/Database/DBHelper.dart';
import 'dart:io' as io;
import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class SignInPage extends StatefulWidget{

  static String tag = 'signup-page';
  @override
  _SignInPageState createState() => new _SignInPageState();
}

class _SignInPageState extends State<SignInPage>{

  Database db;
  DatabaseHelper mdb;
  io.Directory documentDirectory;
  String path;
  final String test ='vvvv';
  static final TextEditingController tfUser = new TextEditingController(text: "");
  static final TextEditingController tfPass = new TextEditingController(text: "");

  void navigationPage() {
    setState(() {
      Navigator.of(context).pushReplacementNamed('/DashboardMenu');
    });
  }

  void showToast(String str){
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        //bgcolor: "#000000",
        //textcolor: '#ffffff'
    );
  }

  _insertDB() async{
    try {
      tfUser.clear();
      int a = await db.rawDelete("DELETE FROM user");
      await db.rawInsert("insert into user values('vvvv','ggggg')");
      await db.rawInsert("insert into user values('aaaa','hhhh')");
      await db.rawInsert("insert into user values('bbbbb','rrrrr')");
      print(a);
    }catch(e) {
      print("error in update: $e");
    }
  }

  _getdataDB() async{
    String b = "";
    try {
      List<Map> list = await db.rawQuery("select * from user where username='$test'");
      for(int i = 0; i < list.length; i++) {
        b= list[i]["password"];
        print(b);
        tfUser.text = b;
      }
      if(b=='ggggg'){
        showToast("wakakaka");
      }else{
        showToast("uupps");
      }
    }catch(e) {
      print("error in update: $e");
    }
  }

  void initState(){
    super.initState();
    _openDB();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }

  _openDB() async{
    documentDirectory = await getApplicationDocumentsDirectory();
    path = p.join(documentDirectory.path, 'main.db');
    db = await openDatabase(path);
  }


  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'main_logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60.0,
        child: Image.asset('assets/image/deb_coll_white_copy.png'),
      ),
    );

    final applabel = FlatButton(
      child: Text(
        Theme.textStr.appTitle,
        style: TextStyle(color: Theme.Colors.blueLight,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Swiss',
        ),
      ),
      onPressed: () {},
    );

    final appTitle = FlatButton(
      child: Text(
        Theme.textStr.signInTitle,
        style: TextStyle(color: Theme.Colors.blueLight,
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: () {},
    );

    final bodyLayout = new Card(
        elevation: 10.0,
        margin: const EdgeInsets.all(16.0) ,
        child: new Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 5.0),
              appTitle,
              SizedBox(height: 15.0),
              new TextField(
                textAlign: TextAlign.left,
                controller: tfUser,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  hintText: 'Enter Your Name',
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                    borderSide: new BorderSide(
                      color: Theme.Colors.rect,
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              new TextField(
                textAlign: TextAlign.left,
                controller: tfPass,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  hintText: 'Enter Your Password',
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                    borderSide: new BorderSide(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.0),
            ],
          ),
        )
    );

    return Scaffold(
      backgroundColor: Theme.Colors.backgroundSplash,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          children: <Widget>[
            SizedBox(height: 5.0),
            logo,
            applabel,
            new Divider(
              height: 1.0,
            ),
            SizedBox(
              height: 1.0,
              child: new Center(
                child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 1.0,
                  color: Theme.Colors.backgroundSplash,
                ),
              ),
            ),
            bodyLayout,
            SizedBox(height: 35.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ButtonTheme(
                  height: 15.0,
                  minWidth: 140.0,
                  child: MaterialButton(
                    onPressed: () => _insertDB(),
                    elevation: 10.0,
                    child: new Text(Theme.textStr.submit,
                      style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),),
                    color: Theme.Colors.blueLight,
                    height: 40.0,
                    minWidth: 140.0,
                  ),
                ),
                ButtonTheme(
                  height: 15.0,
                  minWidth: 140.0,
                  child: MaterialButton(
                    onPressed: () => _getdataDB(),
                    elevation: 10.0,
                    child: new Text(Theme.textStr.cancel,
                      style: TextStyle(color: Colors.grey, fontSize: 20.0, fontWeight: FontWeight.bold),),
                    color: Colors.white,
                    height: 40.0,
                    minWidth: 140.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),
          ],
        ),
      ),
    );
  }
}
