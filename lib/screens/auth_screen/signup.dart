import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trip_planner/apiService/apis.dart';
import 'package:trip_planner/const.dart';
import 'package:trip_planner/dialogs/dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trip_planner/screens/bottomNavScreen/homepage.dart';
import '../../main.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../bottomNav.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  _handlegooglelogin(){
    dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      Navigator.pop(context);
      if(user!=null){
        if((await apis.userExist())){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>BottomNav()));
        }else{
          await apis.createUser().then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>BottomNav())));
        }
      }
    });
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try{
      await InternetAddress.lookup("google.com");
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await apis.auth.signInWithCredential(credential);
    }catch(e){
      dialogs.showSnackbar(context, "Something wents wrong");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            "images/login.png",
            height: mq.height * 0.5,
            width: mq.width,
          ),
          SizedBox(
            height: mq.height * 0.1,
          ),
          Text(
            "Explore the world with us",
            style: TextStyle(fontSize: 25),
          ),
          SizedBox(
            height: mq.height * 0.04,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: appcolor,
              shape: StadiumBorder(),
            ),
            onPressed: () {
              //on pressed function call
              _handlegooglelogin();
            },
            label: Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                "Sign in with Google",
                style: TextStyle(fontSize: 23),
              ),
            ),
            icon: Image.asset(
              "images/google.png",
              height: mq.height * 0.04,
            ),
          ),
        ],
      ),
    );
  }

}
