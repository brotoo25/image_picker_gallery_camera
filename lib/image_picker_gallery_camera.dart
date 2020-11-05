library image_picker_gallery_camera;

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerGC {
  static Future pickImage({
    @required BuildContext context,
    @required ImgSource source,
    double maxWidth,
    double maxHeight,
    Icon cameraIcon,
    Icon galleryIcon,
    Widget cameraText,
    Widget galleryText,
    bool barrierDismissible = false,
    int imageQuality,
  }) async {
    assert(source != null);
    assert(imageQuality == null || (imageQuality >= 0 && imageQuality <= 100));

    if (maxWidth != null && maxWidth < 0) {
      throw ArgumentError.value(maxWidth, 'maxWidth cannot be negative');
    }

    if (maxHeight != null && maxHeight < 0) {
      throw ArgumentError.value(maxHeight, 'maxHeight cannot be negative');
    }

    final _picker = ImagePicker();

    switch (source) {
      case ImgSource.Camera:
        return await _picker.getImage(
            source: ImageSource.camera,
            maxWidth: maxWidth,
            maxHeight: maxHeight);
        break;
      case ImgSource.Gallery:
        return await _picker.getImage(
            source: ImageSource.gallery,
            maxWidth: maxWidth,
            maxHeight: maxHeight);
        break;
      case ImgSource.Both:
        return await showDialog<void>(
          context: context,
          barrierDismissible: barrierDismissible, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      _picker
                          .getImage(
                              source: ImageSource.gallery,
                              maxWidth: maxWidth,
                              maxHeight: maxHeight,
                              imageQuality: imageQuality)
                          .then((image) {
                        Navigator.pop(context, image);
                      });
                    },
                    child: Container(
                      child: ListTile(
                          title: galleryText ?? Text("Gallery"),
                          leading: galleryIcon != null
                              ? galleryIcon
                              : Icon(
                                  Icons.image,
                                  color: Colors.deepPurple,
                                )),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 1,
                    color: Colors.black12,
                  ),
                  InkWell(
                    onTap: () async {
                      _picker
                          .getImage(
                              source: ImageSource.camera,
                              maxWidth: maxWidth,
                              maxHeight: maxHeight)
                          .then((image) {
                        Navigator.pop(context, image);
                      });
                    },
                    child: Container(
                      child: ListTile(
                          title: cameraText ?? Text("Camera"),
                          leading: cameraIcon != null
                              ? cameraIcon
                              : Icon(
                                  Icons.camera,
                                  color: Colors.deepPurple,
                                )),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      case ImgSource.Remove:
        return await showDialog<void>(
          context: context,
          barrierDismissible: barrierDismissible, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  InkWell(
                    onTap: () async {
                      _picker
                          .getImage(
                              source: ImageSource.gallery,
                              maxWidth: maxWidth,
                              maxHeight: maxHeight,
                              imageQuality: imageQuality)
                          .then((image) {
                        Navigator.pop(context, image);
                      });
                    },
                    child: Container(
                      child: ListTile(
                          title: galleryText ?? Text("Gallery"),
                          leading: galleryIcon != null
                              ? galleryIcon
                              : Icon(
                                  Icons.image,
                                  color: Colors.deepPurple,
                                )),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 1,
                    color: Colors.black12,
                  ),
                  InkWell(
                    onTap: () async {
                      _picker
                          .getImage(
                              source: ImageSource.camera,
                              maxWidth: maxWidth,
                              maxHeight: maxHeight)
                          .then((image) {
                        Navigator.pop(context, image);
                      });
                    },
                    child: Container(
                      child: ListTile(
                          title: cameraText ?? Text("Camera"),
                          leading: cameraIcon != null
                              ? cameraIcon
                              : Icon(
                                  Icons.camera,
                                  color: Colors.deepPurple,
                                )),
                    ),
                  ),
                  Container(
                    width: 200,
                    height: 1,
                    color: Colors.black12,
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context, null);
                    },
                    child: Container(
                      child: ListTile(
                        title: cameraText ?? Text("Remove Image"),
                        leading: Icon(
                          Icons.remove_circle_outline,
                          color: Colors.red[300],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
    }
  }
}

enum ImgSource { Camera, Gallery, Both, Remove }
