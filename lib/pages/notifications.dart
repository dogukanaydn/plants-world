import 'package:flutter/material.dart';
import 'package:plants_world/theme/constants.dart';

class Notifications extends StatefulWidget {
  Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
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
      body: ListViewHome(),
    );
  }
}

class ListViewHome extends StatefulWidget {
  @override
  _ListViewHomeState createState() => _ListViewHomeState();
}

class _ListViewHomeState extends State<ListViewHome> {
  bool isWatered = false;

  final titles = [
    "Bitki 1",
    "Bitki 2",
    "Bitki 3",
    "Bitki 4",
    "Bitki 5",
    "Bitki 6",
    "Bitki 7",
    "Bitki 8",
    "Bitki 9",
    "Bitki 10",
    "Bitki 11",
    "Bitki 12",
    "Bitki 13",
  ];

  final subtitles = [
    "15 minute ago",
    "1 hour ago",
    "1 day ago",
    "15 minute ago",
    "1 hour ago",
    "1 day ago",
    "15 minute ago",
    "1 hour ago",
    "1 day ago",
    "15 minute ago",
    "1 hour ago",
    "1 day ago",
    "15 minute ago",
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              color: isWatered == true
                  ? AppConstants.lightPurple
                  : AppConstants.lightRed,
              child: ListTile(
                title: Text(
                  titles[index],
                  style: isWatered == true
                      ? TextStyle(color: Colors.black)
                      : TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  subtitles[index],
                  style: isWatered == true
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
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1491147334573-44cbb4602074?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80"),
                ),
                trailing: isWatered == true
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
                        onPressed: () {},
                      ),
              ),
            ),
          );
        });
  }
}
