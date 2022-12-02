import 'package:json_annotation/json_annotation.dart';

part 'create_playlist.g.dart';

@JsonSerializable()
class CreatePlaylist {
  CreatePlaylist(this.id, this.href);

  String id;
  String href;

  factory CreatePlaylist.fromJson(Map<String, dynamic> json) =>
      _$CreatePlaylistFromJson(json);

  Map<String, dynamic> toJson() => _$CreatePlaylistToJson(this);
}
