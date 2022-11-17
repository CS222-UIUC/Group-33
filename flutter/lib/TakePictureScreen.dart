import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:http/http.dart' as http;
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'DisplayPictureScreen.dart';

// camera screen
class TakePictureScreen extends StatefulWidget {
  // TakePictureScreen({
  //   super.key,
  //   // required this.camera,
  // });

  // final CameraDescription camera = widget.firstCamera as CameraDescription;

  // @override
  // TakePictureScreenState createState() => TakePictureScreenState();
  @override
  var cameras = null;
  var camera;
  Future<void> initState() async {
    try {
      cameras = await availableCameras();
      camera = cameras.first;
    } on CameraException catch (e) {
      logError(e.code, e.description);
    }
  }

  // final CameraDescription camera = firstCamera as CameraDescription;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

void logError(String code, String? description) {
  print('code: ');
  print(code);
  print('description: ');
  print(description);
}

//-------------------------------------------------------------

//added
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
  void initState() {
    super.initState();
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
            await _initializeControllerFuture;

            // retrieves picture
            final image = await _controller.takePicture();
            final path = image.path;
            final bytes = await File(path).readAsBytes();
            final img.Image imageToAPI = img.decodeImage(bytes);

            //send image to backend and retrieves emotion
            // make a Uri from the API
            var uri = Uri.parse('https://moodspot1.pythonanywhere.com/check');

            // here is our main request
            var request = http.MultipartRequest('POST', uri)
              ..files.add(await http.MultipartFile.fromPath(
                  'file', // the label by which you must send the file
                  imageToAPI as String, // the image file, where ever you store that
                ));

            var response = await request.send();
            var topEmotion = response['dominant_emotion'];
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
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}
