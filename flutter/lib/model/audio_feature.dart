import 'package:json_annotation/json_annotation.dart';

part 'audio_feature.g.dart';

@JsonSerializable()
class AudioFeature {
  AudioFeature(
    this.danceability,
    this.energy,
    this.valence,
    this.mode,
    this.uri,
  );

  String uri;
  double danceability;
  double energy;
  double valence;
  int mode;

  factory AudioFeature.fromJson(Map<String, dynamic> json) =>
      _$AudioFeatureFromJson(json);

  Map<String, dynamic> toJson() => _$AudioFeatureToJson(this);
}
