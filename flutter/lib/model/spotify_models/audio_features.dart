import 'package:json_annotation/json_annotation.dart';

import 'package:semaphoreci_flutter_demo/model/spotify_models//audio_feature.dart';

part 'audio_features.g.dart';

// ignore_for_file: non_constant_identifier_names
@JsonSerializable()
class AudioFeatures {
  AudioFeatures(this.audio_features);

  List<AudioFeature?> audio_features;

  factory AudioFeatures.fromJson(Map<String, dynamic> json) =>
      _$AudioFeaturesFromJson(json);

  Map<String, dynamic> toJson() => _$AudioFeaturesToJson(this);
}
