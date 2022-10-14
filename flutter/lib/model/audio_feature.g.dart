// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_feature.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioFeature _$AudioFeatureFromJson(Map<String, dynamic> json) => AudioFeature(
      (json['danceability'] as num).toDouble(),
      (json['energy'] as num).toDouble(),
      (json['valence'] as num).toDouble(),
      json['mode'] as int,
      json['uri'] as String,
    );

Map<String, dynamic> _$AudioFeatureToJson(AudioFeature instance) =>
    <String, dynamic>{
      'uri': instance.uri,
      'danceability': instance.danceability,
      'energy': instance.energy,
      'valence': instance.valence,
      'mode': instance.mode,
    };
