
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/painting.dart';
import 'package:test_app/SignUpPage.dart';
import 'package:test_app/Theme.dart' as Theme;
import 'package:test_app/test2.dart';
import 'package:test_app/test_listview2.dart';
import 'package:test_app/camera.dart';
import 'package:test_app/design/FurnitureUI.dart';
import 'package:test_app/design/HireTalentUI.dart';
import 'package:test_app/CameraTest.dart';

class FrontPage extends StatefulWidget{
  static String tag = 'front-page';
  @override
  _FrontPageState createState() => new _FrontPageState();
}

class _FrontPageState extends State<FrontPage> {

  final Color backgroundSplash=const Color(0xffFCDEAC);
  final Color blueLight=const Color(0xff3F51B5);

  void navigationPage() {
    setState(() {
      Navigator.of(context).pushReplacementNamed('/SignInPage');
    });

  }

  void navigationPage2() {
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>new SignUpPage('test aja nich')));
    });

  }

  void navigationPage3() {
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>new TestListView2()));
    });

  }

  void navigationPage4() {
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>new Test2()));
    });

  }

  void navigationPage5() {
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>new FurnitureUI()));
    });

  }

  void navigationPage6() {
    setState(() {
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>new HireTalentUI()));
    });

  }

  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
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
            SizedBox(height: 35.0),
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
            applabel,
            SizedBox(height: 110.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new MaterialButton(
                  child: new Text(Theme.textStr.signup,
                    style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold),),
                  color: blueLight,
                  height: 40.0,
                  minWidth: 130.0,
                  elevation: 4.0,
                  onPressed: () => navigationPage2(),
                  ),
                ButtonTheme(
                  height: 15.0,
                  minWidth: 130.0,
                  child: MaterialButton(
                    onPressed: () => navigationPage(),
                    elevation: 4.0,
                    child: new Text(Theme.textStr.signin,
                      style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold),),
                    color: blueLight,
                    height: 40.0,
                    minWidth: 130.0,
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new MaterialButton(
                  child: new Text(Theme.textStr.camera,
                    style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold),),
                  color: blueLight,
                  height: 40.0,
                  minWidth: 130.0,
                  elevation: 4.0,
                  onPressed: () => navigationPage4(),
                ),
                ButtonTheme(
                  height: 15.0,
                  minWidth: 130.0,
                  child: MaterialButton(
                    onPressed: () => navigationPage3(),
                    elevation: 4.0,
                    child: new Text(Theme.textStr.listview,
                      style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold),),
                    color: blueLight,
                    height: 40.0,
                    minWidth: 130.0,
                  ),
                ),
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new MaterialButton(
                  child: new Text(Theme.textStr.furnitureui,
                    style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold),),
                  color: blueLight,
                  height: 40.0,
                  minWidth: 130.0,
                  elevation: 4.0,
                  onPressed: () => navigationPage5(),
                ),
                ButtonTheme(
                  height: 15.0,
                  minWidth: 130.0,
                  child: MaterialButton(
                    onPressed: () => navigationPage6(),
                    elevation: 4.0,
                    child: new Text(Theme.textStr.hiretalentui,
                      style: TextStyle(color: Colors.white, fontSize: 13.0, fontWeight: FontWeight.bold),),
                    color: blueLight,
                    height: 40.0,
                    minWidth: 130.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );

  }
}