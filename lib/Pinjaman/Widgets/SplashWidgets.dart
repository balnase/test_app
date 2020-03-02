import 'package:flutter/material.dart';

class SplashWidgets extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var assetsImage = new AssetImage('assets/image/logo2.png');
    var image = new Image(image: assetsImage, width: 200.0, height: 200.0,);
    return new Container(child: image);
  }
}