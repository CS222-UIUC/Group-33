//added
import 'dart:io';
import 'package:flutter/material.dart';

//displays picture
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen(this.imagePath, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
    );
  }
}
