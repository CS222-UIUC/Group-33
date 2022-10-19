import 'package:flutter/material.dart';

import 'package:semaphoreci_flutter_demo/pages/emotion_page.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Text('Camera Page'),
          TextButton(
            onPressed: logoutButton,
            child: const Text('Identify Emotion ->'),
            key: const ValueKey('button.emotion'),
          )
        ],
      ),
    );
  }

  void logoutButton() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const EmotionPage(),
      ),
    );
  }
}
