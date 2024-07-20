import 'dart:convert';

import 'package:infinite_scroll_search/models/dimensions_models.dart';
import 'package:infinite_scroll_search/models/meta_models.dart';
import 'package:infinite_scroll_search/models/review_models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_models.g.dart';

@JsonSerializable()
class ProductModels {
  int? id;
  String? title;
  String? description;
  String? category;
  double? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  List<String>? tags;
  String? brand;
  String? sku;
  double? weight;
  Dimensions? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List<Review>? reviews;
  String? returnPolicy;
  int? minimumOrderQuantity;
  Meta? meta;
  String? thumbnail;
  List<String>? images;

  ProductModels({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.meta,
    this.thumbnail,
    this.images,
  });

  Map<String, dynamic> toJson() => _$ProductModelsToJson(this);

  factory ProductModels.fromJson(Map<String, dynamic> json) => _$ProductModelsFromJson(json);
}
