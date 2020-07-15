import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


import 'package:flutter/widgets.dart';
import 'package:wemove/constants.dart';
import 'package:wemove/registration/signin.dart';

class SizeConfig{
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init (BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal = _mediaQueryData.padding.left
        +
        _mediaQueryData.padding.right;

    _safeAreaVertical = _mediaQueryData.padding.top
        +
        _mediaQueryData.padding.bottom;

    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) /100;

  }
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.transparent,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                      ]),
                    )
                  ]));
        });
  }
}




class ConfirmEmail extends StatefulWidget {
  @override
  _ConfirmEmailState createState() => _ConfirmEmailState();
}

class _ConfirmEmailState extends State<ConfirmEmail> with SingleTickerProviderStateMixin {

  Animation animation, animation1, animation2, animation3, animation4, rotate;
  AnimationController animationController, animationController1;

  @override
  void initState() {
    super.initState();
//    animationController1 = AnimationController(duration: Duration(milliseconds: 500), vsync: this,
//    upperBound: pi* 2);
    // RotationTransition(turns: null)
    // rotate =
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    animation1 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 1.0, curve: Curves.fastOutSlowIn)));

    animation2 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    animation3 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn)));

    animation4 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.9, 1.0, curve: Curves.fastOutSlowIn)));

  }
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final TextEditingController _email = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final String BASE_URL = 'http://medsaid.herokuapp.com/api/';
  var data, new_data;

  Future confirmEmail(BuildContext context) async{
    final formState = _formkey.currentState;
    if(formState.validate()){
      Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      final response = await http.post("${BASE_URL}users/confirm/email/", body: {
        'email': _email.text
      });
      print(response.body);
      if(response.statusCode == 200){
        data = json.decode(response.body);
        new_data = data["results"];
        print(new_data);
        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop(); //close the dialoge
        Navigator.push(context, MaterialPageRoute(builder: (context) => AnswersPage(new_data)));
      }else {
        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
        data = json.decode(response.body);
        var details =data["detail"];
        print(response.body);
        showDialog(context: context,
            barrierDismissible: true,
            child: CupertinoAlertDialog(
              content: Text(
                "${details}",
                style: TextStyle(fontSize: 16.0),
              ),
            ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var _blank = FocusNode();
    final double width = MediaQuery
        .of(context)
        .size.width;
    animationController.forward();
    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context , Widget child){
          SizeConfig().init(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: false,
              title: Text('WeMove'),
            ),
            backgroundColor: kPrimaryColor,
            body: GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(_blank);
              },
              child: Column(
                children: [
                  SizedBox(height: kDefaultPadding / 2),
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        // Our background
                        Container(
                          margin: EdgeInsets.only(top: 70),
                          decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                        ),

                        Center(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Form(
                                key: _formkey,
                                child: Column(
                                  children: <Widget>[
                                    Transform(
                                      transform: Matrix4.translationValues(animation2.value*width, 0.0, 0.0),
                                      child: Container(
                                        width: 300,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.black),
                                            borderRadius: BorderRadius.circular(15)
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(left:10.0),
                                          child: TextFormField(
                                            onSaved: (input) => this._email,
                                            controller: _email,
                                            style: TextStyle(fontSize: 20),
                                            decoration: InputDecoration(hintText: "Email",
                                                hintStyle: TextStyle(
                                                    fontFamily: 'ReemKufi'
                                                ),
                                                border: InputBorder.none),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:45.0),
                                      child: Transform(
                                        transform: Matrix4.translationValues(animation3.value*width, 0.0, 0.0),
                                        child: Container(
                                            width: 300,
                                            height: 50,
//                                    decoration: BoxDecoration(
//                                        color: Colors.blue,
//                                        border: Border.all(color: Colors.blue),
//                                        borderRadius: BorderRadius.only(
//                                            topRight: Radius.circular(30),
//                                            bottomLeft: Radius.circular(30),
//
//                                        )
//                                    ),
                                            child: RaisedButton(
                                                color: Colors.blue,
                                                textColor: Colors.black,
                                                shape: CircleBorder(
                                                    side: BorderSide(
                                                        color: Colors.blue
                                                    )
                                                ),
//                                      RoundedRectangleBorder(
//                                          borderRadius: BorderRadius.only(
//                                              topRight: Radius.circular(30),
//                                              bottomLeft: Radius.circular(30),
//                                              topLeft: Radius.circular(30),
//                                          )
//                                      ),
                                                onPressed: (){
                                                  //confirmEmail(context);
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => AnswersPage(new_data)));
                                                },
                                                elevation: 5,
                                                child:Icon(Icons.arrow_forward,
                                                  color: Colors.white,)
                                            )
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });

  }
}


class AnswersPage extends StatefulWidget {
  final user_data;
  @override

  AnswersPage(this.user_data);
  _AnswersPageState createState() => _AnswersPageState(this.user_data);
}

class _AnswersPageState extends State<AnswersPage> with SingleTickerProviderStateMixin {

  Animation animation, animation1, animation2, animation3, animation4, rotate;
  AnimationController animationController, animationController1;

  @override
  void initState() {
    super.initState();
//    animationController1 = AnimationController(duration: Duration(milliseconds: 500), vsync: this,
//    upperBound: pi* 2);
    // RotationTransition(turns: null)
    // rotate =
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    animation1 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 1.0, curve: Curves.fastOutSlowIn)));

    animation2 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    animation3 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn)));

    animation4 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.9, 1.0, curve: Curves.fastOutSlowIn)));

  }

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final TextEditingController _answer = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final user_data;
  final String BASE_URL = 'http://medsaid.herokuapp.com/api/';
  var data;
  var new_data;

  _AnswersPageState(this.user_data);

  Future confirmAnswer(BuildContext context) async{
    final formState = _formkey.currentState;
    if(formState.validate()){
      Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      final response = await http.post("${BASE_URL}users/confirm/answer/", body: {
        'answer': _answer.text, 'user_id': this.user_data["user_id"].toString()
      });
      print(response.body);
      if(response.statusCode == 200){
        data = json.decode(response.body);
        new_data = data["results"];
        print(new_data);
        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
        Navigator.of(context).pop();
        Navigator.push(context, MaterialPageRoute(builder: (context) => SetPassword(new_data)));
      }else{
        {
          Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
          data = json.decode(response.body);
          var details =data["detail"];
          print(response.body);
          showDialog(context: context,
              barrierDismissible: true,
              child: CupertinoAlertDialog(
                content: Text(
                  "${details}",
                  style: TextStyle(fontSize: 16.0),
                ),
              ));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var _blank = FocusNode();
    final double width = MediaQuery
        .of(context)
        .size.width;
    animationController.forward();
    return AnimatedBuilder(animation: animationController,
        builder: (BuildContext context, Widget child){
          SizeConfig().init(context);
          return Scaffold(
            appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            title: Text('WeMove'),
          ),
          backgroundColor: kPrimaryColor,
            body: GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(_blank);
              },
              child: Column(
                children: [
                  SizedBox(height: kDefaultPadding / 2),
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 70),
                          decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                        ),
                        Center(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:10.0),
                                child: Transform(
                                  transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                                  child: Text("Hi  ",
                                    style: TextStyle(color: Colors.black87, fontSize: 23, fontFamily:'OpenSans'),),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:15.0, left: 10),
                                child: Transform(
                                  transform: Matrix4.translationValues(animation1.value*width, 0.0, 0.0),
                                  child: Text("Please answer the question below with the exact"
                                      " answer you gave whiles signing up", style: TextStyle(
                                      color: Colors.black87, fontSize: 23, fontFamily:'OpenSans'),),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top:20.0, left:10),
                                child: Align(alignment: Alignment.centerLeft,
                                    child: Transform(
                                        transform: Matrix4.translationValues(animation2.value*width, 0.0, 0.0),
                                        child: Text("Security Question:", style: TextStyle(color: Colors.black87, fontSize: 23,fontFamily:'OpenSans'),))),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Transform(
                                    transform: Matrix4.translationValues(animation2.value*width, 0.0, 0.0),
                                    child: Text("sdf ", style: TextStyle(color: Colors.redAccent, fontSize: 20, fontFamily:'OpenSans'),)),
                              ),
                              Form(
                                key: _formkey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Transform(
                                        transform: Matrix4.translationValues(animation3.value*width, 0.0, 0.0),
                                        child: Container(
                                          width: 300,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.black),
                                              borderRadius: BorderRadius.circular(15)
                                          ),
                                          child: TextFormField(
                                            onSaved: (input) => this._answer,
                                            controller: _answer,
                                            style: TextStyle(fontSize: 20),
                                            decoration: InputDecoration(hintText: "Answer",
                                                hintStyle: TextStyle(fontFamily: 'ReemKufi'),
                                                 contentPadding: EdgeInsets.all(8),
                                                 border: InputBorder.none),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top:35.0),
                                      child: Transform(
                                        transform: Matrix4.translationValues(animation4.value*width, 0.0, 0.0),
                                        child: Container(
                                            width: 300,
                                            height: 50,
//                                      decoration: BoxDecoration(
//                                          color: Colors.blue,
//                                          border: Border.all(color: Colors.blue),
////                                          borderRadius: BorderRadius.only(
////                                              topRight: Radius.circular(30),
////                                              bottomLeft: Radius.circular(30)
////                                          )
//                                      ),
                                            child: RaisedButton(
                                              color: Colors.blue,
                                              textColor: Colors.black,
                                              shape: CircleBorder(
                                                  side: BorderSide(
                                                    color: Colors.blue,

                                                  )
                                              ),
                                              onPressed: (){
                                               // confirmAnswer(context);
                                                Navigator.push(context, MaterialPageRoute(builder: (_)=>SetPassword(data)));
                                              },
                                              elevation: 5,
                                              child: Icon(Icons.arrow_forward,
                                                color:Colors.white ,),
                                            )
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top:35.0),
                                        child: GestureDetector(
                                          child: Transform(
                                              transform: Matrix4.translationValues(animation4.value*width, 0.0, 0.0),
                                              child: Text("Not me! Change email", style: TextStyle(fontSize: 20),)), onTap: (){
                                          Navigator.of(context).pop();
                                        },)
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });

  }
}


class SetPassword extends StatefulWidget {
  final data;

  const SetPassword(this.data);
  @override
  _SetPasswordState createState() => _SetPasswordState(this.data);
}

class _SetPasswordState extends State<SetPassword> with SingleTickerProviderStateMixin{

  Animation animation, animation1, animation2, animation3, animation4, rotate;
  AnimationController animationController, animationController1;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  void initState() {
    super.initState();
//    animationController1 = AnimationController(duration: Duration(milliseconds: 500), vsync: this,
//    upperBound: pi* 2);
    // RotationTransition(turns: null)
    // rotate =
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    animation1 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 1.0, curve: Curves.fastOutSlowIn)));

    animation2 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn)));

    animation3 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.7, 1.0, curve: Curves.fastOutSlowIn)));

    animation4 = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.9, 1.0, curve: Curves.fastOutSlowIn)));

  }


  final TextEditingController _newPassword = TextEditingController();

  final TextEditingController _confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final user_data;
  final String BASE_URL = 'http://medsaid.herokuapp.com/api/';
  var data;
  var new_data;

  _SetPasswordState(this.user_data);

  Future setPassword(BuildContext context) async{
    final formState = _formkey.currentState;
    if(formState.validate()){
      Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
      final response = await http.post("${BASE_URL}users/reset/password/", body: {
        "user_id": this.user_data["user_id"],
        "new_password": _newPassword.text,
        "confirm_password": _confirmPassword.text,
      });

      print(response.body);
      if(response.statusCode == 200){
        data = json.decode(response.body);
        new_data = data["results"];
        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
        Navigator.of(context).pop();
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
      }else{
        {
          Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
          data = json.decode(response.body);
          var details =data["detail"];
          print(response.body);
          showDialog(context: context,
              barrierDismissible: true,
              child: CupertinoAlertDialog(
                content: Text(
                  "${details}",
                  style: TextStyle(fontSize: 16.0),
                ),
              ));
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    var _blank = FocusNode();
    final double width = MediaQuery
        .of(context)
        .size.width;
    animationController.forward();

    return AnimatedBuilder(animation: animationController,
        builder: (BuildContext context, Widget child){
          SizeConfig().init(context);
          return Scaffold(
           appBar: AppBar(
              elevation: 0,
              centerTitle: false,
              title: Text('WeMove'),
            ),
            backgroundColor: kPrimaryColor,
            body: GestureDetector(
              onTap: (){
                FocusScope.of(context).requestFocus(_blank);
              },
              child: Column(
                children: [
                  SizedBox(height: kDefaultPadding / 2),
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 70),
                          decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                        ),
                        Center(
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top:20.0),
                                    child: Transform(
                                      transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                                      child: Text("Set Password", style: TextStyle(fontSize: 35,
                                          fontFamily: 'OpenSans'),),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(top:25.0),
                                    child: Form(
                                      key: _formkey,
                                      child: Column(
                                        children: <Widget>[
                                          Transform(
                                            transform: Matrix4.translationValues(animation1.value*width, 0.0, 0.0),
                                            child: Container(
                                              width: 300,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.black),
                                                  borderRadius: BorderRadius.circular(15)
                                              ),
                                              child: TextFormField(
                                                onSaved: (input) => this._newPassword,
                                                controller: _newPassword,
                                                obscureText: true,
                                                style: TextStyle(fontSize: 23),
                                                decoration: InputDecoration(hintText: "New Password",
                                                    contentPadding: EdgeInsets.all(8),
                                                    hintStyle: TextStyle(fontFamily: 'ReemKufi', fontSize: 20),
                                                     border: InputBorder.none),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 40.0),
                                            child: Transform(
                                              transform:  Matrix4.translationValues(animation3.value*width, 0.0, 0.0),
                                              child: Container(
                                                width: 300,
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.black),
                                                    borderRadius: BorderRadius.circular(15)
                                                ),
                                                child: TextFormField(
                                                  onSaved: (input) => this._confirmPassword,
                                                  controller: _confirmPassword,
                                                  obscureText: true,
                                                  style: TextStyle(fontSize: 23),
                                                  decoration: InputDecoration(hintText: "Confirm Password",
                                                      contentPadding: EdgeInsets.all(8),
                                                      hintStyle: TextStyle(fontFamily: 'ReemKufi', fontSize: 20),
                                                       border: InputBorder.none),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top:40.0),
                                            child: Transform(
                                              transform: Matrix4.translationValues(animation4.value*width, 0.0, 0.0),
                                              child: Container(
                                                  width: 300,
                                                  height: 50,
                                                  child: RaisedButton(
                                                      color: Colors.blue,
                                                      textColor: Colors.black,
                                                      shape:CircleBorder(
                                                          side: BorderSide(color: Colors.blue)
                                                      ),
                                                      onPressed: (){
                                                        setPassword(context);
                                                      },
                                                      elevation: 5,
                                                      child:Icon(Icons.arrow_forward,
                                                          color: Colors.white)
                                                  )
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );

  }
}
