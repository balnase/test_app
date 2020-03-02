import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_app/Theme.dart' as Theme;
import 'package:fluttertoast/fluttertoast.dart';


class SignUpPage extends StatefulWidget{
  SignUpPage(this._str);

  final String _str;
  static String tag = 'signup-page';

  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>{
  String txtMessage ='';
  static final TextEditingController tfUser = new TextEditingController(text: "");
  static final TextEditingController tfSurname = new TextEditingController(text: "");
  static final TextEditingController tfPass = new TextEditingController(text: "");
  static final TextEditingController tfConfirmPass = new TextEditingController(text: "");

  final FocusNode _userFocus = FocusNode();
  final FocusNode _surnameFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  final FocusNode _confirmpassFocus = FocusNode();

  void navigationPage() {
    setState(() {
      Navigator.of(context).pushReplacementNamed('/SignInPage');
    });
  }

  void initPage(){
    setState(() {
        tfUser.clear();
        tfSurname.clear();
        tfPass.clear();
        tfConfirmPass.clear();
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

  void validateForm(){
      if(tfUser.text == ''){
        txtMessage = 'User Cannot Empty';
      }else if(tfSurname.text == ''){
        txtMessage = 'Surname Cannot Empty';
      }else if (tfPass.text == ''){
        txtMessage = 'Password Cannot Empty';
      }else if(tfConfirmPass.text == ''){
        txtMessage = 'Confirm Password Cannot Empty';
      }else{
        txtMessage = '';
      }

      if(txtMessage == ''){
        //showToast("OKE");
        navigationPage();
      }else{
        showToast(txtMessage);
      }
  }

  void initState(){
    super.initState();
    showToast(widget._str);
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
        Theme.textStr.signUpTitle,
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
              controller: tfSurname,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                hintText: 'Enter Your Surname',
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
            SizedBox(height: 15.0),
            new TextField(
              textAlign: TextAlign.left,
              controller: tfConfirmPass,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                hintText: 'Enter Your Confirm Password',
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
            SizedBox(height: 20.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                ButtonTheme(
                  height: 15.0,
                  minWidth: 140.0,
                  child: MaterialButton(
                    onPressed: () => validateForm(),
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
                    onPressed: () => initPage(),
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