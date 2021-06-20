import 'dart:async';

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
  final MyPlantsController _controller = MyPlantsController();
  final RealtimeDB _realtimeDB = RealtimeDB();
  Timestamp isNextWatered;
  Timestamp isWatered;

  @override
  Timer timer;

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 10), (_) {
      setState(() {});
    });
  }

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

              isNextWatered = data['time_next_watered'];
              isWatered = data['time_watered'];

              var isWateredFormatDateTime = isWatered.toDate();
              var timeOfNow = DateTime.now();
              Duration difference =
                  timeOfNow.difference(isWateredFormatDateTime);
              var timeago = difference.inSeconds;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Card(
                  color: isNextWatered.toDate().isAfter(DateTime.now()) == true
                      ? AppConstants.lightPurple
                      : AppConstants.lightRed,
                  child: ListTile(
                    title: Text(
                      data['plant_name'],
                      style:
                          isNextWatered.toDate().isAfter(DateTime.now()) == true
                              ? TextStyle(color: Colors.black)
                              : TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "You watered $timeago seconds ago ",
                      style:
                          isNextWatered.toDate().isAfter(DateTime.now()) == true
                              ? TextStyle(
                                  color: Colors.red,
                                  // fontWeight: FontWeight.w100,
                                  fontStyle: FontStyle.italic)
                              : TextStyle(
                                  color: Colors.black,
                                  // fontWeight: FontWeight.w100,
                                  fontStyle: FontStyle.italic),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(data['photo']),
                    ),
                    trailing:
                        isNextWatered.toDate().isAfter(DateTime.now()) == true
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
                                  //_realtimeDB.updateData();
                                  _controller.setWater(
                                      plantName: data['plant_name'],
                                      wateringTime: data['watering_time']);
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

  Future _showDialog(String plantName, String photo, int wateringTime) async {
    var data = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CustomDialog(
          plantName: plantName,
          photo: photo,
          wateringTime: wateringTime,
        );
      },
    );
    // Navigator.pop(context, time);
    return data;
  }
}
