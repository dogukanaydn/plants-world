import 'package:flutter/material.dart';
import 'package:plants_world/theme/constants.dart';

class Search extends StatefulWidget {
  Search({Key key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: MyCustomForm(),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  List<int> listOfImages = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: AppConstants.searchGrey,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              hintText: 'Search for plants',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'All Plants',
            style: CustomTextHeadline.headLine6,
          ),
        ),
        Expanded(
          child: _buildGrid(),
        )
      ],
    );
  }

  Padding plantsImages() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: 100,
            height: 100,
            color: AppConstants.lightPurple,
          ),
          Positioned(
            top: 6,
            left: 6,
            right: 6,
            child: Container(
              width: 90,
              height: 69,
              color: Colors.white,
            ),
          ),
          Positioned(
            bottom: 4,
            left: 6,
            child: Text('Bitki adı'),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 150,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: _buildGridTileList(30));

  List<Container> _buildGridTileList(int count) =>
      List.generate(count, (i) => Container(child: plantsImages()));
}
