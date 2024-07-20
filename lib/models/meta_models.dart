import 'package:json_annotation/json_annotation.dart';

part 'meta_models.g.dart';

@JsonSerializable()
class Meta {
  String? createdAt;
  String? updatedAt;
  String? barcode;
  String? qrCode;

  Meta({
    this.createdAt,
    this.updatedAt,
    this.barcode,
    this.qrCode,
  });

  Map<String, dynamic> toJson() => _$MetaToJson(this);

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}
