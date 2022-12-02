// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_artists.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopArtists _$TopArtistsFromJson(Map<String, dynamic> json) => TopArtists(
      json['href'] as String?,
      (json['items'] as List<dynamic>)
          .map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['limit'] as int,
      json['offset'] as int,
      json['total'] as int,
    );

Map<String, dynamic> _$TopArtistsToJson(TopArtists instance) =>
    <String, dynamic>{
      'href': instance.href,
      'items': instance.items,
      'limit': instance.limit,
      'offset': instance.offset,
      'total': instance.total,
    };
