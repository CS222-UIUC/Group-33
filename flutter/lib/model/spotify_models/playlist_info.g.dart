// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistInfo _$PlaylistInfoFromJson(Map<String, dynamic> json) => PlaylistInfo(
      json['name'] as String,
      json['id'] as String,
      PlaylistTracks.fromJson(json['tracks'] as Map<String, dynamic>),
      (json['images'] as List<dynamic>)
          .map((e) => ImageObj.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistInfoToJson(PlaylistInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'tracks': instance.tracks,
      'images': instance.images,
    };
