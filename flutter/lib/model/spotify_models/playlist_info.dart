import 'package:json_annotation/json_annotation.dart';
import 'package:semaphoreci_flutter_demo/model/spotify_models/image_obj.dart';
import 'package:semaphoreci_flutter_demo/model/spotify_models/playlist_tracks.dart';

part 'playlist_info.g.dart';

@JsonSerializable()
class PlaylistInfo {
  PlaylistInfo(this.name, this.id, this.tracks, this.images);

  String name;
  String id;
  PlaylistTracks tracks;
  List<ImageObj> images;

  factory PlaylistInfo.fromJson(Map<String, dynamic> json) =>
      _$PlaylistInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PlaylistInfoToJson(this);
}
