import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plants_world/pages/details.dart';
import 'package:plants_world/theme/constants.dart';
import 'package:tflite/tflite.dart';

class TFLite extends StatefulWidget {
  TFLite({Key key}) : super(key: key);

  @override
  _TFLiteState createState() => _TFLiteState();
}

class _TFLiteState extends State<TFLite> {
  File _imageFile;
  List _classifiedResult;

  @override
  void initState() {
    super.initState();
    loadImageModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String plantName;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.purple,
        title: Text("Plant World"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(2, 2),
                      spreadRadius: 2,
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: (_imageFile != null)
                    ? Image.file(_imageFile)
                    : Image.network('https://i.imgur.com/sUFH1Aq.png')),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: AppConstants.purple),
              onPressed: () {
                selectImage();
              },
              child: Icon(Icons.camera),
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              child: Column(
                children: _classifiedResult != null
                    ? _classifiedResult.map((result) {
                        return Card(
                          elevation: 0.0,
                          color: AppConstants.lightPurple,
                          child: Container(
                            width: 300,
                            margin: EdgeInsets.all(10),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    "${result["label"]} :  ${(result["confidence"] * 100).toStringAsFixed(1)}%",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 50),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor:
                                                AppConstants.purple,
                                            minimumSize: Size(300, 60),
                                            primary: AppConstants.grey),
                                        child: Text(
                                          "Learn More",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () {
                                          plantName = result['label'];
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Details(
                                                plantName: plantName,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList()
                    : [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future loadImageModel() async {
    Tflite.close();
    String result;
    result = await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
    print(result);
  }

  Future selectImage() async {
    final picker = ImagePicker();
    var image =
        await picker.getImage(source: ImageSource.gallery, maxHeight: 300);
    classifyImage(image);
  }

  Future classifyImage(image) async {
    _classifiedResult = null;
    // Run tensorflowlite image classification model on the image
    print("classification start $image");
    final List result = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    print("classification done");
    setState(() {
      if (image != null) {
        _imageFile = File(image.path);
        _classifiedResult = result;
      } else {
        print('No image selected.');
      }
    });
  }
}
