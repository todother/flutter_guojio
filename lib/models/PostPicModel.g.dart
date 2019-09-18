// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostPicModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostPicModel _$PostPicModelFromJson(Map<String, dynamic> json) {
  return PostPicModel(
    json['picID'] as String,
    json['picIndex'] as int,
    json['picPath'] as String,
    json['picSimpPath'] as String,
    (json['picsRate'] as num)?.toDouble(),
    json['postsID'] as String,
  );
}

Map<String, dynamic> _$PostPicModelToJson(PostPicModel instance) =>
    <String, dynamic>{
      'picID': instance.picID,
      'postsID': instance.postsID,
      'picPath': instance.picPath,
      'picIndex': instance.picIndex,
      'picSimpPath': instance.picSimpPath,
      'picsRate': instance.picsRate,
    };
