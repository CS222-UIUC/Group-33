// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'followed_artists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowedArtists _$FollowedArtistsFromJson(Map<String, dynamic> json) =>
    FollowedArtists(
      FollowArtist.fromJson(json['artists'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FollowedArtistsToJson(FollowedArtists instance) =>
    <String, dynamic>{
      'artists': instance.artists,
    };
