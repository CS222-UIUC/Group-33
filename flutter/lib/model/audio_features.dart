import 'package:json_annotation/json_annotation.dart';

import 'package:semaphoreci_flutter_demo/model/audio_feature.dart';

part 'audio_features.g.dart';

@JsonSerializable()
class AudioFeatures {
  AudioFeatures(this.audioFeatures);

  List<AudioFeature> audioFeatures;

  factory AudioFeatures.fromJson(Map<String, dynamic> json) =>
      _$AudioFeaturesFromJson(json);

  Map<String, dynamic> toJson() => _$AudioFeaturesToJson(this);
}
