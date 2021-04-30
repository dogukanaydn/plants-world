import 'package:flutter/material.dart';
import 'package:plants_world/theme/constants.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
      body: ListViewHome(),
    );
  }
}

class ListViewHome extends StatefulWidget {
  @override
  _ListViewHomeState createState() => _ListViewHomeState();
}

class _ListViewHomeState extends State<ListViewHome> {
  bool isWatered = true;

  final titles = [
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
    "Kendi İsimlendirmen",
  ];

  final subtitles = [
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi",
    "Bitki Türünün İsmi"
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Card(
              color: AppConstants.lightPurple,
              child: ListTile(
                title: Text(
                  titles[index],
                  style: TextStyle(color: Colors.black),
                ),
                subtitle: Text(
                  subtitles[index],
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                      fontStyle: FontStyle.italic),
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1491147334573-44cbb4602074?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80"),
                ),
                trailing: Icon(
                  Icons.delete,
                  color: AppConstants.lightRed,
                ),
              ),
            ),
          );
        });
  }
}
