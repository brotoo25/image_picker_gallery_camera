# image_picker_gallery_camera

Flutter Package to Pick Image From Gallery or Camera

## Getting Started

A Flutter plugin for iOS and Android for picking images from the image library, and taking new pictures with the camera.
You can use both Camera and Gallery Option.

### Installation 

First, add `image_picker_gallery_camera` as a dependency in your pubspec.yaml file.

### iOS

Add the following keys to your Info.plist file, located in <project root>/ios/Runner/Info.plist:

    NSPhotoLibraryUsageDescription - describe why your app needs permission for the photo library. This is called Privacy - Photo Library Usage Description in the visual editor.
    NSCameraUsageDescription - describe why your app needs access to the camera. This is called Privacy - Camera Usage Description in the visual editor.
    NSMicrophoneUsageDescription - describe why your app needs access to the microphone, if you intend to record videos. This is called Privacy - Microphone Usage Description in the visual editor.

### Android 

No configuration required - the plugin should work out of the box.

### Final Output

![](image_picker_flutter.gif)

## Example

```
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker_gallery_camera/image_picker_gallery_camera.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example Image Picker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Example Image Picker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File _image;

  Future getImage(ImgSource source) async {
    var image = await ImagePickerGC.pickImage(
        context: context,
        source: source,
        cameraIcon: Icon(
          Icons.add,
          color: Colors.red,
        ),//cameraIcon and galleryIcon can change. If no icon provided default icon will be present
    );
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                child: RaisedButton(
                  onPressed: () => getImage(ImgSource.Gallery),
                  color: Colors.blue,
                  child: Text(
                    "From Gallery".toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: RaisedButton(
                  onPressed: () => getImage(ImgSource.Camera),
                  color: Colors.deepPurple,
                  child: Text(
                    "From Camera".toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: 300,
                child: RaisedButton(
                  onPressed: () => getImage(ImgSource.Both),
                  color: Colors.red,
                  child: Text(
                    "Both".toUpperCase(),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              _image != null ? Image.file(_image) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
```
