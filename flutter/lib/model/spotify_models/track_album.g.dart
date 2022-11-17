// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrackAlbum _$TrackAlbumFromJson(Map<String, dynamic> json) => TrackAlbum(
      (json['images'] as List<dynamic>)
          .map((e) => ImageObj.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TrackAlbumToJson(TrackAlbum instance) =>
    <String, dynamic>{
      'images': instance.images,
    };
