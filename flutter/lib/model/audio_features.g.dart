// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_features.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioFeatures _$AudioFeaturesFromJson(Map<String, dynamic> json) =>
    AudioFeatures(
      (json['audioFeatures'] as List<dynamic>)
          .map((e) => AudioFeature.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AudioFeaturesToJson(AudioFeatures instance) =>
    <String, dynamic>{
      'audioFeatures': instance.audioFeatures,
    };
