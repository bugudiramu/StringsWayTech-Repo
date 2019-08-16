import 'dart:io';
import 'package:image_editor/cloud_uploder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File _image;

  getImageFile(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    print(_image?.lengthSync());
    return Scaffold(
      appBar: AppBar(
        title: Text("StringsWay Image Editor"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: _image == null
                  ? Text(
                      "Image will be shown here".toUpperCase(),
                    )
                  : Image.file(
                      _image,
                      height: 300,
                      width: 300,
                    ),
            ),
            SizedBox(height: 20.0),
            CloudUploader(file: _image),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton.extended(
            label: Text("Camera"),
            onPressed: () => getImageFile(ImageSource.camera),
            heroTag: UniqueKey(),
            icon: Icon(Icons.camera),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton.extended(
            label: Text("Gallery"),
            onPressed: () => getImageFile(ImageSource.gallery),
            heroTag: UniqueKey(),
            icon: Icon(Icons.photo_library),
          ),
        ],
      ),
    );
  }
}
