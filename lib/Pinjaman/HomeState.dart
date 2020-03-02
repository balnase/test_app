import 'package:flutter/material.dart';
import 'package:test_app/Pinjaman/TextUtil.dart' as Utils;
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class HomeState extends StatefulWidget{
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<HomeState>{
  var txtNominal = "";
  var txtNominalFinal = "";
  int a;
  double b,c,total,nominal;
  var controller = new MoneyMaskedTextController();
  static final TextEditingController tfNominal = new TextEditingController(text: "");
  static final TextEditingController tfTenor = new TextEditingController(text: "");
  static final TextEditingController tfBunga = new TextEditingController(text: "");

  final FocusNode _nominalFocus = FocusNode();
  final FocusNode _tenorFocus = FocusNode();
  final FocusNode _bungaFocus = FocusNode();

  final formatter = new NumberFormat("###,###", "en_US");

  void initState(){
    super.initState();
    txtNominal = "Cicilan Per Bulan";
    txtNominalFinal = "Rp 0.00";
  }

  void hitungNilai() {
    String num = tfNominal.text;
    //a= int.tryParse(num);
    nominal=controller.numberValue;
    if(tfTenor.text == '' || tfTenor.text=='0') {
      b = 1;
    }else{
      b = double.tryParse(tfTenor.text);
    }
    double hitbung=0;
    if(tfBunga.text == '' || tfBunga.text=='0') {
      c = 0;
    }else{
      c = (double.tryParse(tfBunga.text))/100;
    }
    //hitbung = (a*c)*b;
    hitbung = (nominal*c)*b;
    //total = (hitbung+a)/b;
    total = (hitbung+nominal)/b;
    //String nilTotal = double.parse(total.toString());
    print('${c}');
    setState(() {
      txtNominalFinal = "Rp ${formatter.format(total)}";
    });
  }

  void initReset() {
    setState(() {
      txtNominal = "Cicilan Per Bulan";
      txtNominalFinal = "Rp 0.00";
      //tfNominal.text = "";
      controller.updateValue(0.00);
      tfBunga.text = "";
      tfTenor.text = "";
      FocusScope.of(context).requestFocus(_nominalFocus);
    });
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        elevation: 5.0,
        title: new Text(Utils.textStr.appTitle, textAlign: TextAlign.left,),
      ),
      body: new GestureDetector(
          onTap: () {
            // call this method here to hide soft keyboard
            FocusScope.of(context).requestFocus(new FocusNode());
          },
        child: Center(
          child: new ListView(
            padding: EdgeInsets.only(left: 18.0, right: 18.0),
            children: <Widget>[
              SizedBox(height: 30.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                      child: Text(
                        "Nominal (Rp)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0
                        ),
                      )
                  ),
                  new Flexible(
                    child: new TextField(
                      textAlign: TextAlign.left,
                      controller: controller,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      focusNode: _nominalFocus,
                      onSubmitted: (v){
                        FocusScope.of(context).requestFocus(_tenorFocus);
                      },
                      decoration: new InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                        hintText: '0',
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
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                      child: Text(
                        "Lama (Bln)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                      )
                  ),
                  new Flexible(
                    child: new TextField(
                      textAlign: TextAlign.left,
                      controller: tfTenor,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      inputFormatters: <TextInputFormatter> [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                      focusNode: _tenorFocus,
                      onSubmitted: (v){
                        FocusScope.of(context).requestFocus(_bungaFocus);
                      },
                      decoration: new InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                        hintText: '0',
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
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                      child: Text(
                        "Bunga (% / Bln)",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17.0),
                      )
                  ),
                  new Flexible(
                    child: new TextField(
                      textAlign: TextAlign.left,
                      controller: tfBunga,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      focusNode: _bungaFocus,
                      inputFormatters: <TextInputFormatter> [
                        BlacklistingTextInputFormatter(RegExp("[abcdefghijklmnopqrstuvwxyz,/?><:;]")),
                      ],
                      decoration: new InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 6.0),
                        hintText: '0',
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
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              new Container(
                height: 1.5,
                width: 250.0,
                color: Utils.Colors.holo_red_dark,
              ),
              SizedBox(height: 20.0),
              new Container(
                height: 100.0,
                decoration: new BoxDecoration(color: Colors.black),
                child: new ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    SizedBox(height: 20.0),
                    new Center(
                      child : new Text(
                        "${txtNominal}",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                    new Center(
                      child : new Text(
                        "${txtNominalFinal}",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              new Container(
                height: 1.5,
                width: 250.0,
                color: Utils.Colors.holo_red_dark,
              ),
              SizedBox(height: 20.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  ButtonTheme(
                    height: 15.0,
                    minWidth: 140.0,
                    child: MaterialButton(
                      onPressed: () => hitungNilai(),
                      elevation: 10.0,
                      child: new Text(Utils.textStr.submit,
                        style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),),
                      color: Utils.Colors.blueLight,
                      height: 40.0,
                      minWidth: 140.0,
                    ),
                  ),
                  ButtonTheme(
                    height: 15.0,
                    minWidth: 140.0,
                    child: MaterialButton(
                      onPressed: () => initReset(),
                      elevation: 10.0,
                      child: new Text(Utils.textStr.cancel,
                        style: TextStyle(color: Colors.white, fontSize: 17.0, fontWeight: FontWeight.bold),),
                      color: Utils.Colors.blueLight,
                      height: 40.0,
                      minWidth: 140.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}