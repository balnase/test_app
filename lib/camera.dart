import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Img;
import 'dart:math' as Math;
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;
import 'dart:typed_data';
import 'package:test_app/Theme.dart' as Theme;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class CameraPage extends StatefulWidget{
  static String tag = 'camera-page';
  @override
  _CameraPageState createState() => new _CameraPageState();
}

class _CameraPageState extends State<CameraPage>{
  File _image;
  Uint8List bytes;
  TextEditingController cTitle = new TextEditingController();
  String base64Image;
  Database db;
  io.Directory documentDirectory;
  String path;

  Future getImageGallery() async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    final tempDir =await getTemporaryDirectory();
    final path = tempDir.path;
    int rand= new Math.Random().nextInt(100000);
    Img.Image image= Img.decodeImage(imageFile.readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image);
    var compressImg= new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));
    setState(() {
      _image = compressImg;
    });
  }

  Future getImageCamera() async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir =await getTemporaryDirectory();
    final path = tempDir.path;

    //int rand= new Math.Random().nextInt(100000);
    //Img.Image image= Img.decodeImage(imageFile.readAsBytesSync());
    //Img.Image smallerImg = Img.copyResize(image, 500);
    //var compressImg= new File("$path/image_$rand.jpg")
     // ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));
    List<int> imageBytes = imageFile.readAsBytesSync();
    //List<int> imageBytes = compressImg.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    _insertDB();
    setState(() {
      //_image = imageFile;
      bytes = base64.decode(base64Image);
    });
  }

  Future getImageCamera2() async{
    var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir =await getTemporaryDirectory();
    final path = tempDir.path;

    ImageProperties properties = await FlutterNativeImage.getImageProperties(imageFile.path);
    File compressedFile = await FlutterNativeImage.compressImage(imageFile.path, quality: 80,
        targetWidth: 600,
        targetHeight: (properties.height * 600 / properties.width).round());

    //int rand= new Math.Random().nextInt(100000);
    //Img.Image image= Img.decodeImage(imageFile.readAsBytesSync());
    //Img.Image smallerImg = Img.copyResize(image, 500);
    //var compressImg= new File("$path/image_$rand.jpg")
    // ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));
    //List<int> imageBytes = imageFile.readAsBytesSync();
    List<int> imageBytes = compressedFile.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    _insertDB();
    setState(() {
      //_image = compressedFile;
      bytes = base64.decode(base64Image);
    });
  }

  Future getImagePath() async{
    //var imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
    final tempDir =await getTemporaryDirectory();
    final path = tempDir.path;

    setState(() {
      cTitle.text = path;
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

  _openDB() async{
    documentDirectory = await getApplicationDocumentsDirectory();
    path = p.join(documentDirectory.path, 'main.db');
    db = await openDatabase(path);
  }

  void initState(){
    super.initState();
    _openDB();
    getImagePath();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
  }

  _insertDB() async{
    try {
      int a = await db.rawDelete("DELETE FROM user");
      int b = await db.rawInsert("insert into user values('vvvv','$base64Image')");
      print(a);
      print(b);
    }catch(e) {
      print("error in update: $e");
    }
  }

  _clearImages(){
    setState(() {
      _image = null;
      bytes =null;
    });
  }

  _showImages() async{
    final tempDir =await getTemporaryDirectory();
    final path = tempDir.path;
    int rand= new Math.Random().nextInt(100000);
    String b = "";
    try {
      List<Map> list = await db.rawQuery("select * from user where username='vvvv'");
      for(int i = 0; i < list.length; i++) {
        b= list[i]["password"];
        print(b);
      }
    }catch(e) {
      print("error in update: $e");
    }
    Uint8List _bytes = base64.decode(b);
    //Img.Image _img = Img.decodeImage(bytes);
    //var imgReal= new File("$path/image_$rand.jpg")
    //  ..writeAsBytesSync(Img.encodeJpg(_img, quality: 55));

    setState(() {
      //_image = imgReal;
      bytes = _bytes;
      cTitle.text=b;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Theme.Colors.backgroundSplash,
      appBar: AppBar(title: Text("Upload Image"),),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 5.0),
            Center(
              child: bytes==null
                  ? new Text("No image selected!")
                  : new Image.memory(bytes),
            ),
            TextField(
              controller: cTitle,
              decoration:new InputDecoration(
                hintText: "Title",
              ),
              style: TextStyle(color: Theme.Colors.appBarTitle),
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Icon(Icons.image),
                  onPressed:(){
                    _showImages();
                    //upload(_image);
                  },
                ),
                RaisedButton(
                  child: Icon(Icons.camera_alt),
                  onPressed: getImageCamera2,
                ),
                Expanded(child: Container(),),
                RaisedButton(
                  child: Text("UPLOAD"),
                  onPressed:(){
                    _clearImages();
                    //upload(_image);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}