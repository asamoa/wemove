import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wemove/constants.dart';
import 'package:wemove/drivers/body.dart';
import 'package:wemove/models/vehicles.dart';


class DriversScreen extends StatelessWidget {
  final Product product;

  const DriversScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: Body(
        product: product,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: Icon(Icons.arrow_back,color: Colors.black,),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
