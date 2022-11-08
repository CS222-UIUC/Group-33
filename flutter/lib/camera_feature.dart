import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'DisplayPictureScreen.dart';

class StartCameraPage extends StatefulWidget() {
  @override
  void initState() {
    var cameras = null;
    var firstCamera = null;
    try {
      cameras = await availableCameras();
    } on CameraException catch (e) {
      logError(e.code, e.description);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: TakePictureScreen createState() => TakePictureScreen(
        // Passing camera to the TakePictureScreen widget
        camera: firstCamera,
      );
    )
  }
}


void logError(String code, String? description) {
  print("code: ");
  print(code);
  print("description: ");
  print(description);
}