import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:semaphoreci_flutter_demo/pages/camera.dart';
import 'package:semaphoreci_flutter_demo/pages/playlist_page.dart';

class EmotionPage extends StatefulWidget {
  final Logger logger;
  const EmotionPage(this.logger, {Key? key}) : super(key: key);

  @override
  State<EmotionPage> createState() => _EmotionPageState();
}

class _EmotionPageState extends State<EmotionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.0, 1.0],
          colors: [
            Color(0xFF00CCFF),
            Color(0xFF3366FF),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              headerRow(),
              imageContainer(),
              displayEmotion(),
              retakePictureBtn(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: createPlaylistBtn(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget headerRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Current Mood',
            style: GoogleFonts.inter(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget imageContainer() {
    return ColorFiltered(
      colorFilter: const ColorFilter.mode(
        Colors.grey,
        BlendMode.saturation,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 45),
        child: Image.asset('img/default_profile_pic.jpg'),
      ),
    );
  }

  Widget displayEmotion() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        'Happy',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 40,
        ),
      ),
    );
  }

  Widget retakePictureBtn() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: TextButton(
        onPressed: retakePictureNav,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.green),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 17,
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 20,
            ),
          ),
          elevation: MaterialStateProperty.all(5),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        child: Text(
          'Retake Picture',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget createPlaylistBtn() {
    return SizedBox(
      width: 0.8 * MediaQuery.of(context).size.width,
      child: TextButton(
        onPressed: createPlaylistNav,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
          textStyle: MaterialStateProperty.all(
            const TextStyle(
              fontSize: 22,
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(
              vertical: 12,
            ),
          ),
          elevation: MaterialStateProperty.all(5),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
        child: Row(
          children: [
            const Spacer(),
            Text(
              'Create Playlist',
              style: GoogleFonts.inter(
                color: Colors.white,
              ),
            ),
            const Expanded(
              child: Icon(
                Icons.chevron_right,
                color: Colors.white,
                size: 23,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void retakePictureNav() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => Camera(widget.logger),
      ),
    );
  }

  void createPlaylistNav() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => PlaylistPage(widget.logger),
      ),
    );
  }
}
