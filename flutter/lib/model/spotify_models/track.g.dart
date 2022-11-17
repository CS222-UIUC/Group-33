// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Track _$TrackFromJson(Map<String, dynamic> json) => Track(
      json['uri'] as String,
      json['duration_ms'] as int,
      json['name'] as String,
      (json['artists'] as List<dynamic>)
          .map((e) => TrackArtist.fromJson(e as Map<String, dynamic>))
          .toList(),
      TrackAlbum.fromJson(json['album'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TrackToJson(Track instance) => <String, dynamic>{
      'uri': instance.uri,
      'duration_ms': instance.duration_ms,
      'name': instance.name,
      'artists': instance.artists,
      'album': instance.album,
    };
