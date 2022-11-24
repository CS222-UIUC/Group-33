import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'DisplayPictureScreen.dart';
import 'dart:convert';

// camera screen
class TakePictureScreen extends StatefulWidget {
  // @override
  // TakePictureScreenState createState() => TakePictureScreenState();
  @override
  // var cameras = null;
  // var camera;
  // void initState() {
  //   print("inside initState line 19");
    // try {
    //   cameras = await availableCameras();
    //   camera = cameras.first;
    //   if(camera == null) {
    //     logError("", "no valid cameras");
    //   } else {
    //     print("found valid camera");
    //   }
    // } on CameraException catch (e) {
    //   logError(e.code, e.description);
    // }
  // }

  // final CameraDescription camera = firstCamera as CameraDescription;

  final CameraDescription camera;
  const TakePictureScreen(this.camera, {Key? key}) : super(key: key);

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

void logError(String code, String? description) {
  print('code: ');
  print(code);
  print('description: ');
  print(description);
}

enum Mood {
  angry,
  disgust,
  happy,
  sad,
  surprise,
  neutral,
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  var cameras = null;
  var camera;
  void initState() {
    print("in initState line 56");
    // await super.initState();

    // @override
    // var cameras = null;
    // var camera;
    //
    // print("inside initState line 64");
    // try {
    //   cameras = await availableCameras();
    //   camera = cameras.first;
    //   if(camera == null) {
    //     logError("", "no valid cameras");
    //   } else {
    //     print("found valid camera");
    //   }
    // } on CameraException catch (e) {
    //   logError(e.code, e.description);
    // }

    //display the current output from the Camera, create a CameraController.
    _controller = CameraController(
      widget.camera as CameraDescription,
      ResolutionPreset.medium,
    );

    //initialize the controller; returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture')),
      // FutureBuilder displays a loading spinner until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        //onPressed callback for taking a picture
        onPressed: () async {
          try {
            print("line 122");
            await _initializeControllerFuture;

            // retrieves picture
            final image = await _controller.takePicture();
            final path = image.path;
            print("line 128");
            final bytes = await File(path).readAsBytes();
            final imageToAPI = img.decodeImage(bytes);
            print("line 131");
            //send image to backend and retrieves emotion
            // make a Uri from the API
            var uri = Uri.parse('https://moodspot1.pythonanywhere.com/check');

            // here is our main request
            var request = http.MultipartRequest('POST', uri)
              ..files.add(await http.MultipartFile.fromBytes(
                'file', // the label by which you must send the file
                bytes, // the image file, where ever you store that
              ));

            var response = await request.send();

            if (response.statusCode >= 200 && response.statusCode < 300) {
              String responseString = await response.stream.bytesToString();

              const JsonDecoder decoder = JsonDecoder();
              final responseMap = decoder.convert(responseString);

              var topEmotion;
              if (!(responseMap["error"] as bool)) {
                topEmotion = responseMap["dominant_emotion"];
              } else {
                throw Exception(responseMap["msg"]);
              }

              //added
              Mood mood = Mood.values.firstWhere(
                  (e) => e.toString() == 'Mood.' + topEmotion.toString());

              if (!mounted) return;

              //display on a new screen
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    imagePath: image.path,
                  ),
                ),
              );
            } else {
              throw Exception('Failed to connect to server.');
            }
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

}
