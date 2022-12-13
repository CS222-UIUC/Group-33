import 'package:json_annotation/json_annotation.dart';
import 'package:semaphoreci_flutter_demo/model/spotify_models/track.dart';

part 'playlist_track.g.dart';

@JsonSerializable()
class PlaylistTrack {
  PlaylistTrack(this.track);

  Track track;

  factory PlaylistTrack.fromJson(Map<String, dynamic> json) =>
      _$PlaylistTrackFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistTrackToJson(this);
}
