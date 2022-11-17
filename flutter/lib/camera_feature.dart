// import 'dart:async';
// import 'dart:developer';
// import 'dart:io';
// // import 'package:image/image.dart' as img;
// // import 'package:http/http.dart' as http;

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'TakePictureScreen.dart';

// class StartCameraPage extends StatefulWidget {
//   @override
//   var cameras = null;
//   var camera;
//   Future<void> initState() async {
//     try {
//       cameras = await availableCameras();
//       camera = cameras.first;
//     } on CameraException catch (e) {
//       logError(e.code, e.description);
//     }
//   }

//   // final CameraDescription camera = firstCamera as CameraDescription;

//   @override
//   TakePictureScreenState createState() => TakePictureScreenState();

//   // @override
//   // TakePictureScreen createState() => TakePictureScreen(
//   //     // camera: firstCamera,
//   //     );

//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: picDisplay.TakePictureScreen createState() => picDisplay.TakePictureScreen(
//   //       // Passing camera to the TakePictureScreen widget
//   //       camera: firstCamera,
//   //     );
//   //   )
//   // }
// }

// void logError(String code, String? description) {
//   print('code: ');
//   print(code);
//   print('description: ');
//   print(description);
// }
