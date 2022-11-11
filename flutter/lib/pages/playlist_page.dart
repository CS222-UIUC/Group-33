import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:semaphoreci_flutter_demo/pages/emotion_page.dart';
import 'package:semaphoreci_flutter_demo/pages/player.dart';
import 'package:semaphoreci_flutter_demo/util/audio_object.dart';
import 'package:semaphoreci_flutter_demo/widgets/detailed_player.dart';

class PlaylistPage extends StatefulWidget {
  final Logger logger;
  const PlaylistPage(this.logger, {Key? key}) : super(key: key);

  @override
  State<PlaylistPage> createState() => _PlaylistPageState();
}

class _PlaylistPageState extends State<PlaylistPage> {
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
              playlistName(),
              viewInSpotifyBtn(),
              // Expanded(child: listOfSongs()),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: listOfSongs(),
                ),
              ),
              const DetailedPlayer(
                audioObject: AudioObject('Song Title', 'Artist', ''),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget headerRow() {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => EmotionPage(widget.logger),
              ),
            );
          },
          child: Row(
            children: [
              const Icon(
                Icons.chevron_left,
                color: Colors.black,
              ),
              Text(
                'Back',
                style: GoogleFonts.inter(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget imageContainer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Image.asset('img/sample_album_img.png'),
        ),
      ),
    );
  }

  Widget playlistName() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Text(
        'Playlist Name',
        style: GoogleFonts.inter(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget viewInSpotifyBtn() {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xff81b2fd),
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
      child: Text(
        'View in Spotify',
        style: GoogleFonts.robotoFlex(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget listOfSongs() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 20,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          dense: true,
          contentPadding: const EdgeInsets.only(
            left: 13,
            right: 20,
          ),
          minVerticalPadding: 10,
          minLeadingWidth: 0,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset('img/sample_album_img.png'),
          ),
          title: Text(
            'Song Name',
            style: GoogleFonts.inter(fontSize: 15),
          ),
          subtitle: Text(
            'Artist',
            style: GoogleFonts.inter(fontSize: 12),
          ),
          trailing: Text(
            '1:03',
            style: GoogleFonts.inter(
              fontSize: 14,
            ),
          ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), //<-- SEE HERE
        ),
        color: const Color(0xffc2d9fc),
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
    );
  }
}
