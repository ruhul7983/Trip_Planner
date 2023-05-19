import 'package:flutter/material.dart';
import 'package:trip_planner/const.dart';
import 'package:trip_planner/apiService/apis.dart';
import '../main.dart';

class PostDetails extends StatefulWidget {
  final String placename;
  final String location;
  final String date;
  final String cost;
  final String details;
  final String image;
  PostDetails({Key? key, required this.placename, required this.location, required this.date, required this.cost, required this.details, required this.image}) : super(key: key);

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  bool isClicked = true;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.placename),
        backgroundColor: appcolor,
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            apis.addToFavorite(widget.placename, widget.location, widget.details, widget.date, widget.cost, widget.image).then((value) => ScaffoldMessenger(child: Text("Added to Favorite")));
          }, icon: Icon(Icons.favorite_outline)),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.image,
              width: mq.width,
              fit: BoxFit.fitHeight,
              height: mq.height*0.4,
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(widget.date,style: TextStyle(fontSize: 18),),
            ),
            SizedBox(
              height: mq.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_sharp,size: 25,
                    color: appcolor,
                  ),
                  Text(widget.location,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,top: 8),
              child: Text(
                widget.details,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: mq.height * 0.08,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,left: 10),
                    child: Text("Tour cost",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                  ),
                  Text('Tk.${widget.cost}',style: TextStyle(fontSize: 18),),
                ],
              ),
            ),
            InkWell(
              onTap: (){},
              splashColor: Colors.red,
              child: Container(
                decoration: BoxDecoration(
                  color: appcolor,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15)),
                ),
                height: mq.height * 0.08,
                width: mq.width * 0.65,
                child: Center(child: Text("Book Now",style: TextStyle(color: Colors.white,fontSize: 25),)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
