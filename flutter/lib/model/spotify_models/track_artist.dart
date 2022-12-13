import 'package:json_annotation/json_annotation.dart';

part 'track_artist.g.dart';

@JsonSerializable()
class TrackArtist {
  TrackArtist(this.name, this.id);

  String name;
  String id;

  factory TrackArtist.fromJson(Map<String, dynamic> json) =>
      _$TrackArtistFromJson(json);

  Map<String, dynamic> toJson() => _$TrackArtistToJson(this);
}
