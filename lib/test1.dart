import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_app/Theme.dart' as Theme;

class Test1 extends StatefulWidget{

  static String tag = 'test1';
  @override
  _Test1State createState() => new _Test1State();
}

class _Test1State extends State<Test1>{
  static final TextEditingController tfUser = new TextEditingController(text: "");
  static final TextEditingController tfSurname = new TextEditingController(text: "");
  static final TextEditingController tfPass = new TextEditingController(text: "");
  static final TextEditingController tfConfirmPass = new TextEditingController(text: "");

  final FocusNode _userFocus = FocusNode();
  final FocusNode _surnameFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  final FocusNode _confirmpassFocus = FocusNode();

  String _username = '';
  String _surname = '';
  String _password = '';
  String _confirmpass = '';
  String _msg;

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

  void _validateForm(){
    setState(() {
      _msg = '';

      if(_username=="" || _username==null){
        _msg = "The item name cannot be empty \n";
      }else if(_surname=="" || _surname==null){
        _msg = _msg +"The item surname cannot be empty \n";
      }else if(_password=="" || _password==null){
        _msg = _msg +"The item password cannot be empty \n";
      }else if(_confirmpass=="" || _confirmpass==null){
        _msg = _msg +"The item repeat password cannot be empty";
      }

      if(_msg != ""){
        showToast(_msg);
      }else{
        if(_password == _confirmpass){
          showToast("OK");
        }else{
          showToast("Re-type password not match with password !");
        }
      }
    });
  }

  void _doClear() {
    setState(() {
      tfUser.text = "";
      tfSurname.text = "";
      tfPass.text = "";
      tfConfirmPass.text = "";
      FocusScope.of(context).requestFocus(_userFocus);
    });
  }

  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'main_logo',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60.0,
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

    final appTitle = FlatButton(
      child: Text(
        Theme.textStr.signUpTitle,
        style: TextStyle(color: Theme.Colors.blueLight,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
        ),
      ),
      onPressed: () {},
    );

    final bodyLayout = new Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        color: Colors.white,
        elevation: 4.0,
        margin: EdgeInsets.only(right: 15.0, left: 15.0),
        child: new Container(
          padding: EdgeInsets.only(left: 15.0, right: 15.0),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 15.0),
              appTitle,
              SizedBox(height: 15.0),
              new Container(
                alignment: new Alignment(0.5, 0.1),
                height: 36.0,
                margin: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 10.0),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration:
                new BoxDecoration(
                    borderRadius: new BorderRadius.all(const Radius.circular(4.0)),
                    border: new Border.all(color: Theme.Colors.rect)),
                child: new TextField(
                  textAlign: TextAlign.left,
                  controller: tfUser,
                  style: TextStyle(fontSize: 14.0, color: Theme.Colors.blueLight),
                  decoration: new InputDecoration.collapsed(hintText: "Enter Your Name"),
                  onChanged: (String value){
                    _username = value;
                  },
                  keyboardType: TextInputType.text,
                  inputFormatters: [ new UpperCaseTextFormatter(), ],
                  textInputAction: TextInputAction.next,
                  focusNode: _userFocus,
                  onSubmitted: (v){
                    FocusScope.of(context).requestFocus(_surnameFocus);
                  },
                ),
              ),
              new Container(
                alignment: new Alignment(0.5, 0.1),
                height: 36.0,
                margin: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 10.0),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration:
                new BoxDecoration(
                    borderRadius: new BorderRadius.all(const Radius.circular(4.0)),
                    border: new Border.all(color: Theme.Colors.rect)),
                child: new TextField(
                  textAlign: TextAlign.left,
                  controller: tfSurname,
                  style: TextStyle(fontSize: 14.0, color: Theme.Colors.blueLight),
                  decoration: new InputDecoration.collapsed(hintText: "Enter Your Surname"),
                  onChanged: (String value){
                    _surname = value;
                  },
                  keyboardType: TextInputType.text,
                  focusNode: _surnameFocus,
                  inputFormatters: [ new UpperCaseTextFormatter(), ],
                  textInputAction: TextInputAction.next,
                  onSubmitted: (v){
                    FocusScope.of(context).requestFocus(_passFocus);
                  },
                ),
              ),
              new Container(
                alignment: new Alignment(0.5, 0.1),
                height: 36.0,
                margin: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 10.0),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration:
                new BoxDecoration(
                    borderRadius: new BorderRadius.all(const Radius.circular(4.0)),
                    border: new Border.all(color: Theme.Colors.rect)),
                child: new TextField(
                  textAlign: TextAlign.left,
                  controller: tfPass,
                  style: TextStyle(fontSize: 14.0, color: Theme.Colors.blueLight),
                  decoration: new InputDecoration.collapsed(hintText: "Enter Your Password"),
                  onChanged: (String value){
                    _password = value;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  focusNode: _passFocus,
                  onSubmitted: (v){
                    FocusScope.of(context).requestFocus(_confirmpassFocus);
                  },
                ),
              ),
              new Container(
                alignment: new Alignment(0.5, 0.1),
                height: 36.0,
                margin: const EdgeInsets.only(left: 16.0,right: 16.0,bottom: 10.0),
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration:
                new BoxDecoration(
                    borderRadius: new BorderRadius.all(const Radius.circular(4.0)),
                    border: new Border.all(color: Theme.Colors.rect)),
                child: new TextField(
                  textAlign: TextAlign.left,
                  controller: tfConfirmPass,
                  style: TextStyle(fontSize: 14.0, color: Theme.Colors.blueLight),
                  decoration: new InputDecoration.collapsed(hintText: "Re-type Your Password"),
                  onChanged: (String value){
                    _confirmpass = value;
                  },
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  focusNode: _confirmpassFocus,
                ),
              ),
              SizedBox(height: 5.0),
            ],
          ),
        ),
    );

    return Scaffold(
      body: Center(
          child: ListView(
            children: <Widget>[
              new Stack(
                children: <Widget>[
                  new Column(
                    children: <Widget>[
                      new Container(
                        height: MediaQuery.of(context).size.height * .35,
                        color: Theme.Colors.backgroundSplash,
                      ),
                      new Container(
                        height: MediaQuery.of(context).size.height * .65,
                        color: Colors.white,
                      )
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      Center(
                        child: new Container(
                          alignment: Alignment.topCenter,
                          padding: new EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .05,
                              right: 20.0,
                              left: 20.0),
                          child: logo,
                        ),
                      ),
                    ],
                  ),
                  new Column(
                    children: <Widget>[
                      Center(
                        child: new Container(
                          alignment: Alignment.topCenter,
                          padding: new EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * .20,
                              right: 20.0,
                              left: 20.0),
                          child: applabel,
                        ),
                      ),
                    ],
                  ),
                  new Container(
                    alignment: Alignment.topCenter,
                    padding: new EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .28,
                        right: 20.0,
                        left: 20.0),
                    child: new Container(
                      height: 285.0,
                      width: MediaQuery.of(context).size.width,
                      child: bodyLayout,
                    ),
                  ),
                  new Container(
                    alignment: Alignment.topCenter,
                    padding: new EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .40,
                        right: 20.0,
                        left: 20.0),
                    child: new Container(
                      height: 300.0,
                      width: MediaQuery.of(context).size.width,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          ButtonTheme(
                            height: 15.0,
                            minWidth: 140.0,
                            child: MaterialButton(
                              onPressed: _validateForm,
                              elevation: 4.0,
                              child: new Text(Theme.textStr.submit,
                                style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),),
                              color: Theme.Colors.blueLight,
                              height: 40.0,
                              minWidth: 140.0,
                            ),
                          ),
                          ButtonTheme(
                              height: 15.0,
                              minWidth: 140.0,
                              child: MaterialButton(
                                onPressed:_doClear,
                                elevation: 4.0,
                                child: new Text(Theme.textStr.cancel,
                                  style: TextStyle(color: Colors.black87, fontSize: 18.0, fontWeight: FontWeight.bold),),
                                color: Theme.Colors.rect,
                                height: 40.0,
                                minWidth: 140.0,
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        ),
      );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue,
      TextEditingValue newValue) {
    return new TextEditingValue(
        text: newValue.text?.toUpperCase(),
    selection: newValue.selection,
    );
  }
}