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
import 'post.dart';


class TestListView2 extends StatefulWidget{

  static String tag = 'testlistview-page';
  @override
  _TestListViewState2 createState() => new _TestListViewState2();
}

class _TestListViewState2 extends State<TestListView2>{
  //var items = new List<String>();
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
  final List<Post> items = new List();

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
        items.add(new Post(dataJSON[i]["userid"], dataJSON[i]["id"], dataJSON[i]["title"], dataJSON[i]["body"]));
        //items.add(dataJSON[i]["title"]);
        bodyTxt.add(dataJSON[i]["body"]);
        print("id : " + d + "\nTitle: " + e);
      }
    }else {
      print('Something went wrong. \nResponse Code : ${response.statusCode}');
    }

    if (!mounted) return;
    setState(() {
      //items = _listItems;
      _isProgressBarShown = false;
    });
  }

  void _onTapItem(BuildContext context, Post post) {
    Scaffold
        .of(context)
        .showSnackBar(new SnackBar(content: new Text(post.id.toString() + ' - ' + post.title)));
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (_isProgressBarShown) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()
          )
      );
    } else {
      widget = new Center(
        child: ListView.builder(
            itemCount: items.length,
            padding: const EdgeInsets.all(15.0),
            itemBuilder: (context, position) {
              return Column(
                children: <Widget>[
                  Divider(height: 5.0),
                  ListTile(
                    title: Text(
                      '${items[position].title}',
                      style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.deepOrangeAccent,
                      ),
                    ),
                    subtitle: Text(
                      '${items[position].body}',
                      style: new TextStyle(
                        fontSize: 12.0,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    leading: Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          radius: 16.0,
                          child: Text('${items[position].title[0]}',
                            //'User ${items[position].id}',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        /*
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () {
                            setState(() {
                              items.removeAt(position);
                            });
                          },
                        ),
                        */
                      ],
                    ),
                    onTap: () => _onTapItem(context, items[position]),
                  ),
                ],
              );
            }),
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
