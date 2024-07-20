import 'package:json_annotation/json_annotation.dart';

part 'dimensions_models.g.dart';

@JsonSerializable()
class Dimensions {
  double? width;
  double? height;
  double? depth;

  Dimensions({
    this.width,
    this.height,
    this.depth,
  });

  Map<String, dynamic> toJson() => _$DimensionsToJson(this);

  factory Dimensions.fromJson(Map<String, dynamic> json) => _$DimensionsFromJson(json);
}
