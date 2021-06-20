import 'package:flutter/material.dart';
import 'package:plants_world/controllers/allPlantsController.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:plants_world/pages/details.dart';
import 'package:plants_world/theme/constants.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  AllPlantsController _allPlantsController = new AllPlantsController();

  @override
  Widget build(BuildContext context) {
    String plantName;

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Search',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _allPlantsController.readItems(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return buildSingleChildScrollView(width, height, data, plantName);
            }).toList(),
          );
        },
      ),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(double width, double height,
      Map<String, dynamic> data, String plantName) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                width: width,
                height: height * 0.5,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  image: DecorationImage(
                      image: NetworkImage(data['photos'][0]),
                      fit: BoxFit.cover),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: AppConstants.purple,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "${data['plant_name']}",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: AppConstants.purple),
                onPressed: () {
                  plantName = data['plant_name'];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Details(
                        plantName: data['plant_name_en'],
                      ),
                    ),
                  );
                },
                child: Text("Learn More"),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
