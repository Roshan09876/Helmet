// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'helmet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelmetModel _$HelmetModelFromJson(Map<String, dynamic> json) => HelmetModel(
      id: json['_id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      helmetType: json['helmetType'] as String?,
      helmetPrice: json['helmetPrice'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$HelmetModelToJson(HelmetModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'decsription': instance.description,
      'helmetType': instance.helmetType,
      'helmetPrice': instance.helmetPrice,
      'image': instance.image,
    };
