import 'package:json_annotation/json_annotation.dart';

part 'image_obj.g.dart';

@JsonSerializable()
class ImageObj {
  ImageObj(this.url, this.height, this.width);

  String url;
  int height;
  int width;

  factory ImageObj.fromJson(Map<String, dynamic> json) =>
      _$ImageObjFromJson(json);

  Map<String, dynamic> toJson() => _$ImageObjToJson(this);
}
