import 'package:flutter/material.dart';
import 'package:plants_world/bottom-navigation-bar/navigation.dart';
import '../theme/constants.dart';

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
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        imageSection,
        buttonSection,
        photoGalleryHeadline,
        photoGallerySection,
        sunmarySection,
      ],
    );
  }

  Widget imageSection = Container(
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
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1619873068038-b25550eeff69?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1918&q=80"),
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
                    "Bitkinin Orjinal İsmi",
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
      "Photo Gallery",
      style: CustomTextHeadline.headLine6,
    ),
  );

  Widget photoGallerySection = Container(
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
                  "https://images.unsplash.com/photo-1619873068038-b25550eeff69?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1918&q=80",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
    ),
  );

  Widget sunmarySection = Container(
    padding: const EdgeInsets.only(left: 25, top: 10, right: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Summary",
          style: CustomTextHeadline.headLine6,
        ),
        Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          softWrap: true,
        ),
        Text(
          "Watering Frequency",
          style: CustomTextHeadline.headLine6,
        ),
        Text(
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          softWrap: true,
        ),
      ],
    ),
  );
}
