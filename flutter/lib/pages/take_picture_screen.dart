//added
import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:semaphoreci_flutter_demo/display_picture_screen.dart';

// camera screen
class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  const TakePictureScreen(this.camera, {super.key});

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

void logError(String code, String description) {
  log('code: ');
  log(code);
  log('description: ');
  log(description);
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

  var cameras;
  var camera;
  void initState() {
    //display the current output from the Camera, create a CameraController.
    _controller = CameraController(
      widget.camera,
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
      //FutureBuilder displays a loading spinner until the controller finishes initializing
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
            await _initializeControllerFuture;

            // retrieves picture
            final image = await _controller.takePicture();
            final path = image.path;
            //send image to backend and retrieves emotion
            // make a Uri from the API
            final uri = Uri.parse('https://moodspot1.pythonanywhere.com/check');

            // here is our main request
            final request = http.MultipartRequest('POST', uri)
              ..files.add(await http.MultipartFile.fromPath(
                'file', // the label by which you must send the file
                path, // the image file, where ever you store that
              ));

            final response = await request.send();

            if (response.statusCode >= 200 && response.statusCode < 300) {
              final responseString = await response.stream.bytesToString();

              const decoder = JsonDecoder();
              final responseMap = decoder.convert(responseString);

              var topEmotion;
              if (!(responseMap['error'] as bool)) {
                topEmotion = responseMap['dominant_emotion'];
              } else {
                throw Exception(responseMap['msg']);
              }

              //added
              final mood = Mood.values.firstWhere(
                    (e) => e.toString() == 'Mood.$topEmotion',);

              log(mood.name);

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
            log(e as String);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

}
