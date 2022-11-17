import 'dart:io';

class MyTrack {
  final String title;
  final String artistNames;
  final String duration;
  final String trackUri;
  final File? imageFile;

  MyTrack(
    this.title,
    this.artistNames,
    this.duration,
    this.trackUri,
    this.imageFile,
  );
}
