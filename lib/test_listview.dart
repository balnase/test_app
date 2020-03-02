import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_app/Database/DBHelper.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:convert';

class TestListView extends StatefulWidget{

  static String tag = 'testlistview-page';
  @override
  _TestListViewState createState() => new _TestListViewState();
}

class _TestListViewState extends State<TestListView>{
  var items = new List<String>();
  var bodyTxt = new List<String>();
  Database db;
  DatabaseHelper mdb= new DatabaseHelper();
  io.Directory documentDirectory;
  String path;
  String e;
  List dataJSON;
  List<String> Names = [
    'Abhishek','John','Robert','Shyam', 'Sita','Gita','Nitish'
  ];
  bool _isProgressBarShown = true;

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
    _getData();
  }

   _getData() async {
     _isProgressBarShown = true;
    var response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {
          "Accept": "application/json"
        }
    );

     List<String> _listItems = new List<String>();
    if (response.statusCode == 200) {

      /*
      setState(() {
        dataJSON = json.decode(response.body);
      });
      */

      dataJSON = json.decode(response.body);
      var a = dataJSON.length;
      var b = a.toString();

      for (int i = 0; i < dataJSON.length; i++) {
        int c = dataJSON[i]["id"];
        e = dataJSON[i]["title"];
        String d = c.toString();
        _listItems.add(dataJSON[i]["title"]);
        //items.add(dataJSON[i]["title"]);
        bodyTxt.add(dataJSON[i]["body"]);
        print("id : " + d + "\nTitle: " + e);
      }
    }else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }

     if (!mounted) return;
     setState(() {
       items = _listItems;
       _isProgressBarShown = false;
     });
  }

  @override
  Widget build(BuildContext context) {

    Widget widget;

    if(_isProgressBarShown) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()
          )
      );
    }else {
      widget =  new Container(
        child: new ListView.builder(
          reverse: false,
          itemBuilder: (_,int index)=>EachList(this.items[index],this.bodyTxt[index],),
          itemCount: this.items.length,

        ),
      );
    }

    return new Scaffold(
      appBar: AppBar(
        title: new Text("Test ListView"),
      ),
      body: widget,
    );
  }
}

class EachList extends StatelessWidget{
  final String name;
  final String bodytxt;
  EachList(this.name, this.bodytxt);

  @override
  Widget build(BuildContext context) {
    return new Card(
            child: new Container(
              width: 300.0,
              padding: EdgeInsets.all(8.0),
              child: new Row(
                children: <Widget>[
                  new Container(
                      padding: new EdgeInsets.only(right: 5.0),
                      child: new CircleAvatar(
                        child: new Text(name[0]),
                        backgroundColor: new Color(0xFFF5F5F5),
                        radius: 16.0,
                      )
                  ),
                  new Padding(padding: EdgeInsets.only(right: 5.0)),
                  new Flexible(
                    child : new GestureDetector(
                      onTap: onCardTapped(name,bodytxt),
                      child : new Container(
                        child: new Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Flexible(
                              child: new Container(
                                padding: new EdgeInsets.only(right: 10.0),
                                child: new Text(
                                  name+"\n",
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Roboto',
                                    color: new Color(0xFF212121),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            new Flexible(
                              child: new Container(
                                padding: new EdgeInsets.only(right: 10.0),
                                child: new Text(
                                  bodytxt,
                                  overflow: TextOverflow.ellipsis,
                                  style: new TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Roboto',
                                    color: new Color(0xFF212121),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        );

  }

  onCardTapped(String name, String body) {
    print('Card $name tapped $body');

  }

}