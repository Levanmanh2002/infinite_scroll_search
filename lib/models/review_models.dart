import 'package:json_annotation/json_annotation.dart';

part 'review_models.g.dart';

@JsonSerializable()
class Review {
  int? rating;
  String? comment;
  String? date;
  String? reviewerName;
  String? reviewerEmail;

  Review({
    this.rating,
    this.comment,
    this.date,
    this.reviewerName,
    this.reviewerEmail,
  });

  Map<String, dynamic> toJson() => _$ReviewToJson(this);

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
