import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/usermodel.dart';

class apis{
  //for me
  static late UserModel me;

  static FirebaseAuth auth = FirebaseAuth.instance;

  //for firestore
  static FirebaseFirestore Firestore = FirebaseFirestore.instance;

  //for storage
  static FirebaseStorage storage = FirebaseStorage.instance;

  //for creating a new user
  static Future createUser() async {
    final currentUser = UserModel(
      image: auth.currentUser!.photoURL.toString(),
      name: auth.currentUser!.displayName.toString(),
      email: auth.currentUser!.email.toString(),
    );
    return await Firestore.collection("users")
        .doc(auth.currentUser!.uid)
        .set(currentUser.toJson());
  }
  static Future userExist() async {
    return (await Firestore.collection("users")
        .doc(auth.currentUser!.uid)
        .get())
        .exists;
  }

  static Future postTrip(String placeName,String Location,String TripDetails,String date,String cost,File file) async {
    final ext = file.path.split('.').last;
    final ref =
    storage.ref().child('post_picture/${DateTime.now()}.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));
    final img = await ref.getDownloadURL();
    await Firestore.collection("post").doc().set(
      {
        "placename":placeName.toString(),
        "Location":Location.toString(),
        "TripDetails":TripDetails.toString(),
        "Date":date.toString(),
        "TourCost":cost.toString(),
        "image":img,
      }
    );
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> postFromFirsebase(){
    return Firestore.collection("post").snapshots();
  }


  static Future addToFavorite(String placeName,String Location,String TripDetails,String date,String cost,String file) async {
    await Firestore.collection("Favourite").doc(auth.currentUser!.email).collection("myFav").doc().set(
        {
          "placename":placeName.toString(),
          "Location":Location.toString(),
          "TripDetails":TripDetails.toString(),
          "Date":date.toString(),
          "TourCost":cost.toString(),
          "image":file.toString(),
        }
    );
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> postFromFavorite(){
    return Firestore.collection("Favourite").doc(auth.currentUser!.email).collection("myFav").snapshots();
  }
  static Future<void> deleteFavorite(String docid){
    return Firestore.collection("Favourite").doc(auth.currentUser!.email).collection("myFav").doc(docid).delete();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getName(){
    return Firestore.collection("users").snapshots();
  }

}