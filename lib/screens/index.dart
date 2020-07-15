import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wemove/constants.dart';
import 'package:wemove/models/PopupMenu.dart';
import 'package:wemove/registration/signin.dart';
import 'package:wemove/registration/signup.dart';
import 'package:wemove/screens/body.dart';


class ProductsScreen extends StatefulWidget {


  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
   choiceAction( String choice){
    if(choice == 'Register'){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>Personal()));
    }else{
      Navigator.push(context, MaterialPageRoute(builder: (_)=>SignIn()));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('WeMove'),
            PopupMenuButton<String>(
                elevation: 2,
                onSelected: choiceAction,
                itemBuilder: (BuildContext context){
                  return Constants.choices.map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                })
          ],
        ),
      ),
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}
