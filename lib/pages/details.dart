import 'package:flutter/material.dart';
import '../theme/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Details extends StatefulWidget {
  Details({Key key}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Details', style: CustomTextHeadline.headLine5),
      ),
      body: DetailsPage(),
    );
  }
}

class DetailsPage extends StatefulWidget {
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference allPlants =
      FirebaseFirestore.instance.collection('All Plants');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: allPlants.doc('2rgaNPy7aGRi3d9DQBUg').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data.data();
          return ListView(
            children: [
              imageSection(data),
              buttonSection,
              photoGalleryHeadline,
              photoGallerySection(data),
              sunmarySection(data),
            ],
          );
        }

        return Text("Hata");
      },
    );
  }

  Widget imageSection(data) => Container(
        child: Stack(
          children: [
            Positioned(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 375,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(100),
                      bottomRight: Radius.circular(100),
                    ),
                    image: DecorationImage(
                        image: NetworkImage("${data['photos'][0]}"),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: AppConstants.purple,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "${data['plant name']}",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Widget buttonSection = Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: AppConstants.purple,
                  minimumSize: Size(150, 50),
                  primary: AppConstants.grey),
              child: Text(
                "Add My Plants",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 15),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: AppConstants.purple,
                  minimumSize: Size(150, 50),
                  primary: AppConstants.grey),
              child: Text(
                "Save to Favorites",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
            ),
          ),
        ),
      ],
    ),
  );

  Widget photoGalleryHeadline = Padding(
    padding: const EdgeInsets.only(left: 25, top: 10),
    child: Text(
      "Photo test",
      style: CustomTextHeadline.headLine6,
    ),
  );

  Widget photoGallerySection(data) => Container(
        padding: EdgeInsets.only(left: 20),
        child: SizedBox(
          height: 100,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      "${data['photos'][index]}",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
        ),
      );

  Widget sunmarySection(data) => Container(
        padding: const EdgeInsets.only(left: 25, top: 10, right: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Summary",
              style: CustomTextHeadline.headLine6,
            ),
            Text(
              "${data['summary']}",
              softWrap: true,
            ),
            Text(
              "Watering Frequency",
              style: CustomTextHeadline.headLine6,
            ),
            Text(
              "${data['watering frequency']}",
              softWrap: true,
            ),
          ],
        ),
      );
}
