import 'package:json_annotation/json_annotation.dart';
import 'package:semaphoreci_flutter_demo/model/spotify_models/track_album.dart';
import 'package:semaphoreci_flutter_demo/model/spotify_models/track_artist.dart';

part 'track.g.dart';

// ignore_for_file: non_constant_identifier_names
@JsonSerializable()
class Track {
  Track(this.uri, this.duration_ms, this.name, this.artists, this.album);

  String uri;
  int duration_ms;
  String name;
  List<TrackArtist> artists;
  TrackAlbum album;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

  Map<String, dynamic> toJson() => _$TrackToJson(this);
}
