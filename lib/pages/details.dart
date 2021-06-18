import 'package:flutter/material.dart';
import 'package:plants_world/bottom-navigation-bar/navigation.dart';
import 'package:plants_world/controllers/myPlantsController.dart';
import '../theme/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Details extends StatefulWidget {
  final String plant_name;
  Details({Key key, this.plant_name}) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final PlantsController _controller = PlantsController();
  // final RealtimeDB _realtimeDB = new RealtimeDB();

  @override
  void initState() {
    super.initState();
    // _realtimeDB.updateData();
    print("plant name: ${widget.plant_name}");

    print(DateTime.now());
    // Timer.periodic(new Duration(seconds: 1), (timer) {
    //   debugPrint(DateTime.now().toString());
    // });
  }

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  CollectionReference allPlants =
      FirebaseFirestore.instance.collection('all_plants');

  @override
  Widget build(BuildContext context) {
    int id;
    String plant_name;
    String photo;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Details', style: CustomTextHeadline.headLine5),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: allPlants.doc(widget.plant_name).get(),
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
            id = data['id'];
            plant_name = data['plant_name'];
            photo = data['photos'][0];
            print("id: $id and plant name: $plant_name");
            return ListView(
              children: [
                imageSection(data),
                buttonSection(id, plant_name, photo),
                photoGalleryHeadline,
                photoGallerySection(data),
                sunmarySection(data),
              ],
            );
          }

          return Text("Hata");
        },
      ),
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
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "${data['plant_name']}",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );

  Widget buttonSection(id, plant_name, photo) => Container(
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
                  onPressed: () {
                    _controller.addItem(
                        id: id, plant_name: plant_name, photo: photo);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NavigationBar()),
                    );
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 10, left: 15),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(20),
            //     child: TextButton(
            //       style: TextButton.styleFrom(
            //           backgroundColor: AppConstants.purple,
            //           minimumSize: Size(150, 50),
            //           primary: AppConstants.grey),
            //       child: Text(
            //         "Save to Favorites",
            //         style: TextStyle(color: Colors.white),
            //       ),
            //       onPressed: () {},
            //     ),
            //   ),
            // ),
          ],
        ),
      );

  Widget photoGalleryHeadline = Padding(
    padding: const EdgeInsets.only(left: 25, top: 10),
    child: Text(
      "Photo Gallery",
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
            SizedBox(
              height: 10,
            ),
            Text(
              "${data['summary']}",
              softWrap: true,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Watering Frequency",
              style: CustomTextHeadline.headLine6,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "${data['watering_frequency']}",
              softWrap: true,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      );
}
