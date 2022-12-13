// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'playlist_tracks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaylistTracks _$PlaylistTracksFromJson(Map<String, dynamic> json) =>
    PlaylistTracks(
      (json['items'] as List<dynamic>)
          .map((e) => PlaylistTrack.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaylistTracksToJson(PlaylistTracks instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
