import 'package:flutter/material.dart';
import 'package:test_app/Theme.dart' as Theme;


class Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Stack(
        children: <Widget>[
          new Container(
            color: Theme.Colors.planetPageBackground,
            child: new Center(
              child: new Hero(
                tag: 'planet-icon-${1}',
                child: new Image(
                  image: new AssetImage('assets/image/deb_coll_white_copy.png'),
                  height: Theme.Dimens.planetHeight,
                  width: Theme.Dimens.planetWidth,
                ),
              ),
            ),
          ),
        ]
    );
  }
}
