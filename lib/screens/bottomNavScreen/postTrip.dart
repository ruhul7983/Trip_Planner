
import 'dart:io';

import 'package:trip_planner/apiService/apis.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trip_planner/const.dart';

import '../../main.dart';
import '../thanks.dart';

class postTrip extends StatefulWidget {
  const postTrip({Key? key}) : super(key: key);

  @override
  State<postTrip> createState() => _postTripState();
}

class _postTripState extends State<postTrip> {
  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  TextEditingController _textFieldController3 = TextEditingController();
  TextEditingController _textFieldController4 = TextEditingController();
  TextEditingController _textFieldController5 = TextEditingController();

  String? _image;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: ()=>FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Post your trip"),
            centerTitle: true,
            backgroundColor: appcolor,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  Card(
                    elevation: 1,
                    child: TextField(
                      controller: _textFieldController1,
                      decoration: InputDecoration(labelText: 'Place Name',hintText: "Place Name"),
                    ),
                  ),

                  Card(
                    elevation: 1,
                    child: TextField(
                      controller: _textFieldController2,
                      decoration: InputDecoration(labelText: 'Location',hintText: "Location"),
                    ),
                  ),
                  Card(

                    elevation: 1,
                    child: TextField(
                      maxLines: 6,
                      controller: _textFieldController3,
                      decoration: InputDecoration(labelText: 'Trip Details',hintText: "Trip Details"),
                    ),
                  ),
                  Card(

                    elevation: 1,
                    child: TextField(
                      onTap: (){

                      },
                      controller: _textFieldController4,
                      decoration: InputDecoration(labelText: 'Journey Date',hintText: "dd/mm/yyyy"),
                    ),
                  ),
                  Card(

                    elevation: 1,
                    child: TextField(
                      controller: _textFieldController5,
                      decoration: InputDecoration(labelText: 'Journey Cost',hintText: "Cost"),
                    ),
                  ),
                  SizedBox(height: mq.height *0.03,),
                  SizedBox(
                    height: mq.height * 0.06,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appcolor,
                        ),
                        onPressed: () async {
                              final ImagePicker picker = ImagePicker();
                              // Pick an image.
                              final XFile? image =
                              await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
                              if(image!=null){
                                _image=image.path;
                              }
                    }, child: Text("Pick Image")),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                InkWell(
                  onTap: (){
                    apis.postTrip(_textFieldController1.text, _textFieldController2.text, _textFieldController3.text, _textFieldController4.text, _textFieldController5.text,File( _image!)).then((value) => Navigator.push(context, MaterialPageRoute(builder: (_)=>ThanksPage())));
                    _textFieldController1.clear();
                    _textFieldController2.clear();
                    _textFieldController3.clear();
                    _textFieldController4.clear();
                    _textFieldController5.clear();
                  },
                  splashColor: Colors.red,
                  child: Container(
                    decoration: BoxDecoration(
                      color: appcolor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                    ),
                    height: mq.height * 0.08,
                    width: mq.width * 0.65,
                    child: Center(child: Text("Post your trip",style: TextStyle(color: Colors.white,fontSize: 25),)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
