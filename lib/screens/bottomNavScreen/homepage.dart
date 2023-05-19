
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../const.dart';
import '../../main.dart';
import 'package:trip_planner/apiService/apis.dart';

import '../../model/postmodel.dart';
import '../../model/usermodel.dart';
import '../postDetails.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> list = [1, 2, 3, 4, 5];
  List<PostModel> list1 = [];
  List<UserModel> listN = [];

  @override
  void initState() {
    apis.postFromFirsebase();
    apis.getName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      // backgroundColor: Colors.white70,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 8.0, top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                    stream: apis.getName(),
                    builder: (context, snapshot) {
                      final data = snapshot.data?.docs;
                      listN = data?.map((e) => UserModel.fromJson(e.data())).toList() ?? [];
                      return Text(
                        "Hello, ${listN.isNotEmpty ? listN[0].name : ''}",maxLines: 1,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: appcolor),
                      );
                    }
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CircleAvatar(
                      backgroundColor: appcolor,
                      child: CircleAvatar(
                        child: listN.isNotEmpty
                            ? Image.network(
                          listN[0].image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error); // Display an error icon if image loading fails
                          },
                        )
                            : Icon(Icons.person), // Placeholder icon if the list is empty
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: mq.height * 0.03),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Explore the world with us",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
            ),
            SizedBox(height: mq.height * 0.07),


            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: apis.postFromFirsebase(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final data = snapshot.data?.docs;
                  list1 = data?.map((e) => PostModel.fromJson(e.data())).toList() ?? [];

                  return Expanded(
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        crossAxisCount: 1,
                        childAspectRatio: 1,
                      ),
                      itemCount: list1.length,
                      itemBuilder: (context, index) {
                        final item = list1[index];
                        if(list1.isNotEmpty){
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PostDetails(
                                    placename: item.placename,
                                    location: item.Location,
                                    date: item.Date,
                                    cost: item.TourCost,
                                    details: item.TripDetails,
                                    image: item.image,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                children: [
                                  Image.network(
                                    item.image,
                                    fit: BoxFit.fitHeight,
                                    height: mq.height * 0.19,
                                    width: mq.width * 0.9,
                                  ),
                                  Positioned(
                                    bottom: 45,
                                    left: 05,
                                    child: Text(
                                      item.placename,maxLines: 1,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 22,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.location_on_sharp,
                                          color: appcolor,
                                        ),
                                        Text(item.Location),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }else{
                          return Center(child: CircularProgressIndicator(),);
                        }

                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error to load data');
                } else {
                  return Center(
                    child: Text("Not yet post"),
                  );
                }
              },
            ),

            SizedBox(height: mq.height * 0.03,),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text("Past",style: TextStyle(color: appcolor,fontSize: 25,fontWeight: FontWeight.w500),),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[300],
                    elevation: 3,
                    child: ListTile(
                      title: Text("Srilanka",style: TextStyle(color: appcolor),),
                      subtitle: Text("ff"),
                    ),
                  );
                },),
            ),
          ],
        ),
      ),
    );
  }
}
