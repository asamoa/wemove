import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:wemove/models/PopupMenu.dart';


void EditModalSheet(context){
  showModalBottomSheet(context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context){
    return Container(

      height: MediaQuery.of(context).size.height * .60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    ),
      ),
      child: BottomModal()
    );
      });
}

class BottomModal extends StatefulWidget {
  @override
  _BottomModalState createState() => _BottomModalState();
}

class _BottomModalState extends State<BottomModal> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fName = TextEditingController();
  final TextEditingController lName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController cPassword = TextEditingController();
  final TextEditingController phone = TextEditingController();
  String dropdownValue;
  @override
  Widget build(BuildContext context) {
    var _blank = FocusNode();
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).requestFocus(_blank);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(

            child: Center(
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
                                          ? 'Number Plate'
                                          : null,
                                      decoration: InputDecoration(
                                          hintText: 'Number Plate',
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
                                          ? 'Location'
                                          : null,
                                      decoration: InputDecoration(
                                          hintText: 'Location',
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
                              width: 300,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 15.0,
                                ),
                                child: PopupMenuButton<String>(
                                  child: Container(
                                   // width: 20,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      //color: Colors.blue,
                                      border: Border.all(color: Colors.black,
                                      width: 0.6),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text('Photo',style: TextStyle(
                                        //fontWeight: FontWeight.w500,
                                        color: Colors.grey
                                      ),),
                                    ),
                                  ),
                                    elevation: 2,
                                    onSelected: choiceAction,
                                    itemBuilder: (BuildContext context){
                                      return Imagery.picker.map((String choice){
                                        return PopupMenuItem<String>(
                                          value: choice,
                                          child: Text(choice),
                                        );
                                      }).toList();
                                    })
                              ),
                            ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                ),
                                showImage(),
                                Padding(
                                    padding: const EdgeInsets.only(top: 20))
                              ],
                            ),
                          ))),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton.extended(
                onPressed:(){
                  Navigator.of(context).pop();
                }, label: Text('Create')),
          ),
        ],
      ),
    );
  }

  // image uploader
  Future<File>file;
  String status = '';

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });

  }

  choiceAction( String choice){
    if(choice == 'Gallery'){
      chooseImage();
    }

  }


  Widget showImage(){
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot){
        if (snapshot.connectionState == ConnectionState.done && null != snapshot.data  ){
           return Flexible(child: Image.file(
             snapshot.data,
             fit: BoxFit.fill,
           )
           );
        } else if(null != snapshot.error){
          return const Text('Error Picking Image',
          textAlign: TextAlign.center,
          );
        }else{
          return const Text('No Image Selected',
          textAlign: TextAlign.center,
          );
        }
      },
    );
  }

}
