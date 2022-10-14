import 'package:json_annotation/json_annotation.dart';

import 'package:semaphoreci_flutter_demo/model/artist.dart';

part 'top_artists.g.dart';

@JsonSerializable()
class TopArtists {
  TopArtists(this.href, this.items, this.limit, this.offset, this.total);

  @JsonKey(defaultValue: null)
  String? href;
  List<Artist> items;
  int limit;
  int offset;
  int total;

  @JsonKey(ignore: true)
  String? next;

  @JsonKey(ignore: true)
  String? previous;

  factory TopArtists.fromJson(Map<String, dynamic> json) =>
      _$TopArtistsFromJson(json);

  Map<String, dynamic> toJson() => _$TopArtistsToJson(this);
}
