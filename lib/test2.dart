import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/Theme.dart' as Theme;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class Test2 extends StatefulWidget{

  @override
  _Test2State createState() => new _Test2State();
}

class _Test2State extends State<Test2>{

  String _status = "";
  String _nama = "";
  String _nokary = "";
  String _masuk = "";
  String _full = "";

  List dataJSON;

  void initState(){
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
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

  Future<List> _checkAbsen() async {
    //final response = await http.post("http://116.0.3.164:8080/top_andro/ProsesDest/incoming/Connector.jsp?Query=205ef759b632|CEK_ABSENSI|MC|");
    var response = await http.post(
        Uri.encodeFull("http://116.0.3.164:8080/top_andro/ProsesDest/incoming/Connector.jsp?Query=205ef759b632|CEK_ABSENSI|MC|"),
        headers: {
          "Accept": "application/json"
        }
    );

    var datauser = json.decode(response.body);
    //dataJSON = json.decode(response.body);
    print (response.body);
    //showToast(response.body);
    if(datauser.length==0){
      setState(() {
        showToast("Fail");
      });
    }else{
      setState(() {
        _status= datauser['status'];
        _nama= datauser['nama'];
        _nokary = datauser['nokary'];
        _masuk = datauser['masuk'];

        if(_nokary==""){
          _nokary = "kosong";
        }
        if(_masuk==""){
          _masuk = "kosong";
        }
        
        _full = "Nama : "+_status+"\nNo Kary : "+_nokary+"\nMasuk : "+_masuk;
      });

      //showToast(_full);
    }
    return datauser;
  }

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {
          "Accept": "application/json"
        }
    );
    dataJSON = json.decode(response.body);
    var a = dataJSON.length;
    var b = a.toString();

    for (int i = 0; i < dataJSON.length; i++) {
      int c = dataJSON[i]["id"];
      String e = dataJSON[i]["title"];
      String d = c.toString();
      print("id : "+d+"\nTitle: "+e);
      //showToast(e);
    }

    //print(response.body);
    return "Success!";
  }

  void _runToast(){
    for (var i = 0; i < dataJSON.length; i++){
          int c = dataJSON[i]["id"];
          String d = c.toString();
          showToast(d);
    }
  }

  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'main_logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 150.0,
        child: Image.asset(Theme.textStr.imgLogo),
      ),
    );

    final applabel = FlatButton(
      child: Text(
        'SDIT AL MUHAJIRIN',
        style: TextStyle(color: Theme.Colors.blueLight,
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
          fontFamily: 'Swiss',
        ),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Theme.Colors.backgroundSplash,
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
                  color: Theme.Colors.backgroundSplash,
                ),
              ),
            ),
            applabel,
            SizedBox(height: 20.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                new MaterialButton(
                  child: new Text("CHECK ABSEN",
                    style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),),
                  color: Theme.Colors.blueLight,
                  height: 40.0,
                  minWidth: 130.0,
                  elevation: 4.0,
                  onPressed: (){
                    //getData();
                    _checkAbsen();
                  },
                ),
              ],
            ),
            SizedBox(height: 15.0),
            new Center(
              child: new Text('$_full',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 18.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}