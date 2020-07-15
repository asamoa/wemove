import 'package:flutter/material.dart';
import 'package:wemove/component/searchbox.dart';
import 'package:wemove/constants.dart';
import 'package:wemove/models/vehicles.dart';
import 'package:wemove/screens/vehicle_show.dart';
import 'package:wemove/screens/vehicle_types.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child:Column(
        children: <Widget>[
          SearchBox(onChanged: (value) {}),
          CategoryList(),
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
                ListView.builder(
                  // here we use our demo procuts list
                  itemCount: products.length,
                  itemBuilder: (context, index) => ProductCard(
                    itemIndex: index,
                    product: products[index],
                    press: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => DetailsScreen(
//                            product: products[index],
//                          ),
//                        ),
//                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}