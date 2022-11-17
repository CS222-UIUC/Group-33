// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_tracks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopTracks _$TopTracksFromJson(Map<String, dynamic> json) => TopTracks(
      (json['tracks'] as List<dynamic>)
          .map((e) => Track.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopTracksToJson(TopTracks instance) => <String, dynamic>{
      'tracks': instance.tracks,
    };
