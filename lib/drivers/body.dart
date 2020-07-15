import 'package:flutter/material.dart';
import 'package:wemove/constants.dart';
import 'package:wemove/models/bottomPopupModal.dart';
import 'package:wemove/models/vehicles.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;

    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}

class Body extends StatelessWidget {
  final Product product;

  const Body({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // it provide us total height and width
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small devices
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 1.6,
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Select a Vehicle',
                  style: TextStyle(fontSize: 20),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          EditModalSheet(context);
                        },
                        child: Card(
                          elevation: 2,
                          color: Colors.amber[50],
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal*40,
                            height: SizeConfig.blockSizeHorizontal*40,
                            child: Image(image: AssetImage("assets/mini.jpg")),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          EditModalSheet(context);
                        },
                        child: Card(
                          elevation: 2,
                          color: Colors.amber[50],
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal*40,
                            height: SizeConfig.blockSizeHorizontal*40,
                            child: Image(image: AssetImage("assets/deliverybike.jpg")),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: kDefaultPadding),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          EditModalSheet(context);
                        },
                        child: Card(
                          elevation: 2,
                          color: Colors.amber[50],
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal*40,
                            height: SizeConfig.blockSizeHorizontal*40,
                            child: Image(image: AssetImage("assets/deliverybike.jpg")),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          EditModalSheet(context);
                        },
                        child: Card(
                          elevation: 2,
                          color: Colors.amber[50],
                          child: Container(
                            width: SizeConfig.blockSizeHorizontal*40,
                            height: SizeConfig.blockSizeHorizontal*40,
                            child: Image(image: AssetImage("assets/mini.jpg")),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: kDefaultPadding),
              ],
            ),
          ),
          SizedBox(height: kDefaultPadding),
          Expanded(
              flex: 2,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Card(
                        color: Colors.white,
                        elevation: 2,
                        child: Container(
                          height: 20,
                          width: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  flex:1,
                                  child: Container(
                                  child:Column(
                                    children: [
                                      Flexible(
                                        flex:1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Text('GN-14-20'),
                                          ],
                                        ),
                                      ),
                                     // SizedBox(height: kDefaultPadding),
                                      Flexible(
                                        flex: 1,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text('Date added'),
                                              ],
                                            )
                                          ],
                                        ),
                                      )

                                    ],
                                  ) ,
                              )),
                              Expanded(
                                  flex:1,
                                  child: Container(
                                    child: Image(image: AssetImage("assets/mini.jpg")),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}


