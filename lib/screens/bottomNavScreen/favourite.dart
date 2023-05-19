import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trip_planner/apiService/apis.dart';
import 'package:trip_planner/screens/postDetails.dart';
import '../../const.dart';
import '../../model/postmodel.dart';

class Favorite extends StatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<PostModel> list1 = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appcolor,
        title: Text("Favorite"),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: apis.postFromFavorite(),
                builder: (context, snapshot) {
                  final data = snapshot.data?.docs;
                  list1 = data?.map((e) => PostModel.fromJson(e.data())).toList() ?? [];
                  if(snapshot.hasError){
                    return Center(child: Text("Error"),);
                  }
                  return ListView.builder(
                      itemCount: list1.length,
                      itemBuilder: (contex,index){
                        DocumentSnapshot _docId = snapshot.data!.docs[index];
                        final item = list1[index];
                        return InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>PostDetails(placename: item.placename, location: item.Location, date: item.Date, cost: item.TourCost, details: item.TripDetails, image: item.image)));
                          },
                          child: Card(
                            elevation: 3,
                            child: ListTile(
                              title: Text(item.placename),
                              subtitle: Text(item.Location),
                              leading: Image.network(item.image),
                              trailing: GestureDetector(
                                  onTap: (){
                                    apis.deleteFavorite(_docId.id);
                                  },
                                  child: CircleAvatar(
                                      backgroundColor: appcolor,
                                      child: Icon(Icons.remove_circle))),
                            ),
                          ),
                        );
                      }
                  );
                }
              )
          ),
        ],
      ),
    );
  }
}
