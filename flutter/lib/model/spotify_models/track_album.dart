import 'package:json_annotation/json_annotation.dart';

import 'package:semaphoreci_flutter_demo/model/spotify_models/image_obj.dart';

part 'track_album.g.dart';

@JsonSerializable()
class TrackAlbum {
  TrackAlbum(this.images);

  List<ImageObj> images;

  factory TrackAlbum.fromJson(Map<String, dynamic> json) =>
      _$TrackAlbumFromJson(json);

  Map<String, dynamic> toJson() => _$TrackAlbumToJson(this);
}
