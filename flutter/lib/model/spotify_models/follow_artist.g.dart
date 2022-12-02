// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'follow_artist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowArtist _$FollowArtistFromJson(Map<String, dynamic> json) => FollowArtist(
      json['href'] as String,
      (json['items'] as List<dynamic>)
          .map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['limit'] as int,
      json['next'] as String?,
      json['total'] as int,
    );

Map<String, dynamic> _$FollowArtistToJson(FollowArtist instance) =>
    <String, dynamic>{
      'href': instance.href,
      'items': instance.items,
      'limit': instance.limit,
      'total': instance.total,
      'next': instance.next,
    };
