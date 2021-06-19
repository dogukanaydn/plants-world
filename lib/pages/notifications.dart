import 'package:flutter/material.dart';
import 'package:plants_world/controllers/myPlantsController.dart';
import 'package:plants_world/controllers/realtime.dart';
import 'package:plants_world/custom_dialog/custom_dialog.dart';
import 'package:plants_world/theme/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final PlantsController _controller = PlantsController();
  final RealtimeDB _realtimeDB = RealtimeDB();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Notifications',
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
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  color: data['is_watered'] == true
                      ? AppConstants.lightPurple
                      : AppConstants.lightRed,
                  child: ListTile(
                    title: Text(
                      data['plant_name'],
                      style: data['is_watered'] == true
                          ? TextStyle(color: Colors.black)
                          : TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "test",
                      style: data['is_watered'] == true
                          ? TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w100,
                              fontStyle: FontStyle.italic)
                          : TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontStyle: FontStyle.italic),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(data['photo']),
                    ),
                    trailing: data['is_watered'] == true
                        ? Icon(
                            Icons.check,
                            color: Colors.green[900],
                          )
                        : TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              minimumSize: Size(100, 40),
                              primary: AppConstants.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            child: Text(
                              "Şimdi Sula",
                              style: TextStyle(color: AppConstants.purple),
                            ),
                            onPressed: () {
                              _showDialog(context, 5);
                              //_realtimeDB.updateData();
                              _controller.setWater(
                                plant_name: data['plant_name'],
                              );
                            },
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

  Future _showDialog(BuildContext context, time) async {
    var data = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          point: time,
        );
      },
    );
    Navigator.pop(context, time);
    return data;
  }
}
