import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:plants_world/theme/constants.dart';
import 'package:plants_world/controllers/myPlantsController.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final MyPlantsController _controller = MyPlantsController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.readItems(),
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
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  color: AppConstants.lightPurple,
                  child: new ListTile(
                    title: Text(
                      data['plant_name'],
                      style: TextStyle(color: Colors.black),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(data['photo']),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _controller.deletePlant(
                          plantName: data['plant_name'],
                        );
                      },
                      // Icons.delete,
                      color: AppConstants.lightRed,
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
