import 'package:flutter/material.dart';

import '../const.dart';

class ThanksPage extends StatelessWidget {
  const ThanksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor,
      body: Center(
        child: Text("Thanks for your post",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
      ),
    );
  }
}
