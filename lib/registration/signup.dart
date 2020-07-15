import 'package:flutter/material.dart';
import 'package:wemove/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:wemove/drivers/drivers.dart';

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
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }
}

class Personal extends StatefulWidget {
  @override
  _PersonalState createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  bool val = false;
  var data;

  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cPassword = TextEditingController();
  final TextEditingController phone = TextEditingController();
  String dropdownValue;

  Future personalInfo(BuildContext context) async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();

      try {
        if (val == true) {
          Dialogs.showLoadingDialog(context, _keyLoader); //invoking login
          final response = await http
              .post('http://medsaid.herokuapp.com/api/users/signup/', body: {
            "first_name": fName.text,
            "last_name": lName.text,
            "email": email.text,
            "password": password.text,
            "confirm_password": cPassword.text,
            "phone_number": phone.text
          });
          Navigator.of(_keyLoader.currentContext, rootNavigator: true)
              .pop(); //close the dialoge

          if (response.statusCode == 201) {
            data = json.decode(response.body);
            print(data);
//            Navigator.push(
//                context,
//                MaterialPageRoute(
//                    builder: (BuildContext context) =>
//                        NewSignIn()));
          } else {
            data = json.decode(response.body);
            var details = data["detail"];
            print(response.body);
            showDialog(
                context: context,
                barrierDismissible: true,
                child: CupertinoAlertDialog(
                  content: Text(
                    "${details}",
                    style: TextStyle(fontSize: 16.0),
                  ),
                ));
          }
        } else {
          return null;
        }
      } catch (e) {
        print(e.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                    Container(
                                      //height: 50,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15.0,
                                        ),
                                        child: TextFormField(
                                          controller: fName,
                                          validator: (input) => input.isEmpty
                                              ? 'Enter First Name'
                                              : null,
                                          decoration: InputDecoration(
                                              hintText: 'First Name',
//                                            icon: Icon(
//                                              FontAwesomeIcons.user,
//                                              color: Colors.black,
//                                              size: 20,
//                                            ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15))),
                                          onSaved: (input) => this.fName,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                    ),
                                    Container(
                                      // height: 50,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15.0,
                                        ),
                                        child: TextFormField(
                                          controller: lName,
                                          validator: (input) => input.isEmpty
                                              ? 'Enter Last Name'
                                              : null,
                                          decoration: InputDecoration(
                                              hintText: 'Last Name',
//                                            icon: Icon(
//                                              FontAwesomeIcons.user,
//                                              color: Colors.black,
//                                              size: 20,
//                                            ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15))),
                                          onSaved: (input) => this.lName,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                    ),
                                    Container(
                                      // height: 50,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 15.0,
                                        ),
                                        child: TextFormField(
                                          controller: email,
                                          validator: (input) => input.isEmpty
                                              ? 'Enter email'
                                              : null,
                                          decoration: InputDecoration(
                                              hintText: 'Email Address',
//                                            icon: Icon(
//                                              FontAwesomeIcons.user,
//                                              color: Colors.black,
//                                              size: 20,
//                                            ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15))),
                                          onSaved: (input) => this.email,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                    ),
                                    Container(
                                      // height: 50,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, bottom: 30),
                                        child: TextFormField(
                                          controller: phone,
                                          validator: (input) => input.isEmpty
                                              ? 'Enter phone number'
                                              : null,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: 'Phone Number',
//                                            icon: Icon(
//                                              FontAwesomeIcons.idCard,
//                                              color: Colors.black,
//                                              size: 20,
//                                            ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15))),
                                          onSaved: (input) => this.phone,
                                        ),
                                      ),
                                    ),

                                    Container(
                                      //height: 60,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: TextFormField(
                                          obscureText: true,
                                          controller: password,
                                          validator: (input) => input.isEmpty
                                              ? 'Enter password'
                                              : null,
                                          decoration: InputDecoration(
                                              hintText: 'Password',
//                                            icon: Icon(
//                                              FontAwesomeIcons.lock,
//                                              color: Colors.black,
//                                              size: 20,
//                                            ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15))),
                                          onSaved: (input) => this.password,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                    ),
                                    Container(
                                      // height: 50,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.transparent,
                                        ),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        child: TextFormField(
                                          obscureText: true,
                                          controller: cPassword,
                                          validator: (input) => input.isEmpty
                                              ? 'Enter Confirm Password'
                                              : null,
                                          decoration: InputDecoration(
                                              hintText: 'Confirm password',
//                                            icon: Icon(
//                                              FontAwesomeIcons.lock,
//                                              color: Colors.black,
//                                              size: 20,
//                                            ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15))),
                                          onSaved: (input) => this.cPassword,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                    ),


                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Checkbox(
                                            value: val,
                                            onChanged: (bool value) {
                                              setState(() {
                                                val = value;
                                              });
                                            }),
                                        Text(
                                          'I agree to the',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              wordSpacing: 3.0),
                                        ),
                                        FlatButton(
                                            onPressed: null,
                                            child: Text(
                                              "Term & Conditions",
                                              style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontWeight: FontWeight.bold,
                                                  decoration:
                                                      TextDecoration.underline),
                                            ))
                                      ],
                                    ),

                                    Padding(
                                        padding: const EdgeInsets.only(top: 30)),
                                    Container(
                                      height: 50,
                                      width: 300,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,

                                        color: Colors.blue,
                                      ),
                                      child: RaisedButton(
                                        elevation: 5,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                        textColor: Colors.white,
                                        color: Colors.blue[800],
                                        shape: CircleBorder(
                                            side: BorderSide(
                                                color: Colors.transparent)),
                                        onPressed: () {
                                          //personalInfo(context);
                                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>DriversScreen()));
                                        },
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 20))
                                  ],
                                ),
                              ))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
