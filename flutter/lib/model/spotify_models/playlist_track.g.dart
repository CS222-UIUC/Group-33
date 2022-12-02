// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistTrack _$PlaylistTrackFromJson(Map<String, dynamic> json) =>
    PlaylistTrack(
      Track.fromJson(json['track'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlaylistTrackToJson(PlaylistTrack instance) =>
    <String, dynamic>{
      'track': instance.track,
    };
