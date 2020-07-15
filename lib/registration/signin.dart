import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:wemove/constants.dart';
import 'package:wemove/drivers/drivers.dart';
import 'package:wemove/registration/reset_password.dart';
import 'package:wemove/registration/signup.dart';

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
//                        SpinKitChasingDots(
//                          color: Colors.blue,
//                          duration: Duration(seconds: 3),
//                          size: 60,
//                        ),
                        SizedBox(height: 10,),
                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }
}

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>with SingleTickerProviderStateMixin {

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

  bool _loading = false;
  var data, token, user, user_profile, results, lat, long, curr;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _user = TextEditingController();
  final TextEditingController _password = TextEditingController();

//  Future signIn(BuildContext context) async{
//    final formState = _formkey.currentState;
//    if(formState.validate()){
//      formState.save();
//      setState(() {
//         _loading = true;
//      });
//
//
//      try{
//        Dialogs.showLoadingDialog(context, _keyLoader);//invoking login
//        final response = await http.post('https://medsaid.herokuapp.com/api/users/signin/', body: {
//          "email": _user.text,
//          "password": _password.text,
//        });
//
//        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
//
//
//        if(response.statusCode == 200){
//          data = json.decode(response.body);
//          token = data["token"]["token"];
//          user = data["user"]["user_full_name"];
//          user_profile = data["user"]["user_profile"];
//
//          final user_locate = await http.get('http://medsaid.herokuapp.com/api/location/', headers: {
//            'Authorization': 'JWT ${data["token"]["token"]}'
//          });
//
//          if(user_locate.statusCode == 200){
//            var our = json.decode(user_locate.body);
//
//            results = our["results"];
//            long = results['longitude'];
//            lat = results['latitude'];
//            curr = results['current_address'];
//
//            Navigator.pushReplacement(context, PageRouteBuilder(pageBuilder: (BuildContext context, animation, secAnimation)=> InMain(this.token, this.user, this.user_profile),
//                transitionsBuilder: (context, animation, secAnimation, child){
//                  return SlideTransition(
//                      position: Tween<Offset>(
//                        begin: const Offset(-1.0, 0.0),
//                        end:  Offset.zero,
//                      ).animate(animation),
//                      child:SlideTransition(position: Tween<Offset>(
//                        begin:  Offset.zero,
//                        end:Offset(-1.0, 0.0),
//                      ).animate(secAnimation),
//                        child: child,
//                      )
//                  );
//                }
//            )
//            );
//            print(response.body);
//            print(curr);
//            //saveTokenPreference(token, user, user_profile, long, lat, curr);
//            print(long);
//          }
//
//
//        }else {
//          //Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();//close the dialoge
//          data = json.decode(response.body);
//          print(data);
//          var details =data["detail"];
//          print(response.body);
//          showDialog(context: context,
//              barrierDismissible: true,
//              child: CupertinoAlertDialog(
//                content: Text(
//                  "${details}",
//                  style: TextStyle(fontSize: 16.0),
//                ),
//              ));
//        }
//      }catch(e){
//        print(e.message);
//      }
//    }
//  }
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery
        .of(context)
        .size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child){
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: false,
            title: Text('WeMove'),
          ),
          backgroundColor: kPrimaryColor,
          body: Column(
            children: <Widget>[
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
                              key: _formKey,
                              child: Theme(
                                  data: ThemeData(
                                    fontFamily: 'OpenSans',
                                    brightness: Brightness.light,
                                  ),
                                  child: Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Transform(
                                          transform: Matrix4.translationValues(animation2.value*width, 0.0, 0.0),
                                          child: Container(
                                            width: 300,
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 15.0),
                                              child: TextFormField(
                                                controller: _user,
//                                                validator: (input) =>
//                                                !EmailValidator.validate(
//                                                    input, true)
//                                                    ? 'Not a valid email.'
//                                                    : null,
                                                onSaved: (input) => this._user,
                                                decoration: InputDecoration(
                                                    hintText: 'Email Address',
//                                            icon: Icon(
//                                              FontAwesomeIcons.user,
//                                              color: Colors.black,
//                                              size: 20,
//                                            ),
                                                    border: OutlineInputBorder(
                                                        borderRadius:BorderRadius.circular(15) )
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                        ),
                                        Transform(
                                          transform: Matrix4.translationValues(animation2.value*width, 0.0, 0.0),
                                          child: Container(
                                            //  height: 40,
                                            width: 300,
                                            //color: Colors.blue,
//                                    decoration: BoxDecoration(
//                                      borderRadius: BorderRadius.circular(50),
//                                      border: Border.all(
//                                        color: Colors.black,
//                                      ),
//                                    ),
                                            child: Padding(
                                              padding:
                                              const EdgeInsets.only(left: 15.0),
                                              child: TextFormField(
                                                controller: _password,
                                                onSaved: (input)=> this._password,
                                                decoration: InputDecoration(
                                                  hintText: 'Password',
//                                          icon: Icon(
//                                            FontAwesomeIcons.lock,
//                                            color: Colors.black,
//                                            size: 20,
//                                          ),
                                                  border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(15)
                                                  ),
                                                ),
                                                obscureText: true,
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                            padding: const EdgeInsets.only(top: 40)),
                                        Container(
                                          height: 50,
                                          width: 300,
//                                              decoration: BoxDecoration(
//                                                borderRadius: BorderRadius.only(
//                                                    bottomLeft: Radius.circular(50),
//                                                    topLeft: Radius.circular(50),
//                                                    topRight: Radius.circular(50)),
//                                                color: Colors.blue,
//                                              ),
                                          child: RaisedButton(
                                            elevation: 5,
                                            child: Icon(Icons.arrow_forward),
//                                                  Text(
//                                                  'Proceed  >',
//                                                  style: TextStyle(
//                                                    fontSize: 16.0,
//                                                    fontFamily: 'Righteous',
//                                                    fontWeight: FontWeight.w600,
//                                                  ),
//                                                ),
                                            textColor: Colors.white,
                                            color: Colors.blue[800],
                                            shape: CircleBorder(
                                                side: BorderSide(
                                                  color: Colors.blue[800],
                                                )
                                            ),
//                                                RoundedRectangleBorder(
//                                                    borderRadius: BorderRadius.only(
//                                                        bottomLeft: Radius.circular(50),
//                                                        topLeft: Radius.circular(50),
//                                                        topRight: Radius.circular(50))
//                                                ),
                                            onPressed: (){
                                              animationController.forward();
                                              var modal = Stack(
                                                children: <Widget>[
                                                  Opacity(
                                                    opacity: 0.3,
                                                    child: const ModalBarrier(
                                                      dismissible: false,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                  Center(
                                                    child: CircularProgressIndicator(),
                                                  )
                                                ],
                                              );
                                              Navigator.push(context, MaterialPageRoute(builder: (_)=> DriversScreen()));
                                              //signIn(context);
                                            },
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.only(top: 40)),
                                        FlatButton(
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> ConfirmEmail()));

                                            },
                                            child: Text(
                                              'Forgot Password',
                                              style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.w600),
                                            )
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 180.0, right: 150.0),
                                          child: new Container(
                                            height: 1.5,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        // Padding(padding: const EdgeInsets.only(top: 5)),
                                        Transform(
                                          transform: Matrix4.translationValues(animation4.value*width, 0.0, 0.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Text(
                                                'New User?',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              FlatButton(
                                                  onPressed:(){

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext context)=> Personal()));
                                                  },
                                                  child: Text(
                                                    'SIGN UP',
                                                    style: TextStyle(
                                                        color: Colors.blue[900],
                                                        fontWeight: FontWeight.w900),
                                                  ))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                              )
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
