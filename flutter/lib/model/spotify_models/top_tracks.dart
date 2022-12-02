import 'package:json_annotation/json_annotation.dart';

import 'package:semaphoreci_flutter_demo/model/spotify_models/track.dart';

part 'top_tracks.g.dart';

@JsonSerializable()
class TopTracks {
  TopTracks(this.tracks);

  List<Track> tracks;

  factory TopTracks.fromJson(Map<String, dynamic> json) =>
      _$TopTracksFromJson(json);

  Map<String, dynamic> toJson() => _$TopTracksToJson(this);
}
