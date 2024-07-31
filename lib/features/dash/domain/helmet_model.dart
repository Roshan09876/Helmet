// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

part 'helmet_model.g.dart';

@JsonSerializable()
class HelmetModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? description;
  final String? helmetType;
  final String? helmetPrice;
  final String? image;
  HelmetModel({
    this.id,
    this.title,
    this.description,
    this.helmetType,
    this.helmetPrice,
    this.image,
  });

   factory HelmetModel.fromJson(Map<String, dynamic> json) =>
      _$HelmetModelFromJson(json);
      
      Map<String, dynamic> toJson() => _$HelmetModelToJson(this);
}
