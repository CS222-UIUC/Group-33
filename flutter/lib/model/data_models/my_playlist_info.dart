import 'dart:io';
import 'package:semaphoreci_flutter_demo/model/data_models/my_track.dart';

class MyPlaylistInfo {
  final String name;
  final String uri;
  final List<MyTrack> tracks;
  final File? imageFile;

  MyPlaylistInfo(this.name, this.uri, this.tracks, this.imageFile);
}
