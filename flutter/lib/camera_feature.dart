import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var cameras = null;
  var firstCamera = null;
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    logError(e.code, e.description);
  }

  runApp(
    MaterialApp(
      theme: ThemeData.dark(),
      home: TakePictureScreen(
        // Passing camera to the TakePictureScreen widget
        camera: firstCamera,
      ),
    ),
  );
}

void logError(String code, String? description) {
  print("code: ");
  print(code);
  print("description: ");
  print(description);
}

//camera screen
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
  super.key,
  required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    //display the current output from the Camera, create a CameraController.
    _controller = CameraController{
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

//displays picture
  class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
  return Scaffold(
  appBar: AppBar(title: const Text('Display the Picture')),
  body: Image.file(File(imagePath)),
  );
  }
  }