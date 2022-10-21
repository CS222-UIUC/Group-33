import 'package:json_annotation/json_annotation.dart';

import 'package:semaphoreci_flutter_demo/model/artist.dart';

part 'follow_artist.g.dart';

@JsonSerializable()
class FollowArtist {
  FollowArtist(this.href, this.items, this.limit, this.next, this.total);

  String href;
  List<Artist> items;
  int limit;
  int total;
  String? next;

  @JsonKey(ignore: true)
  Object? cursors;

  factory FollowArtist.fromJson(Map<String, dynamic> json) =>
      _$FollowArtistFromJson(json);

  Map<String, dynamic> toJson() => _$FollowArtistToJson(this);
}
