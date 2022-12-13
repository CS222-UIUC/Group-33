import 'package:json_annotation/json_annotation.dart';

import 'package:semaphoreci_flutter_demo/model/spotify_models//follow_artist.dart';

part 'followed_artists.g.dart';

@JsonSerializable()
class FollowedArtists {
  FollowedArtists(this.artists);

  FollowArtist artists;

  factory FollowedArtists.fromJson(Map<String, dynamic> json) =>
      _$FollowedArtistsFromJson(json);

  Map<String, dynamic> toJson() => _$FollowedArtistsToJson(this);
}
