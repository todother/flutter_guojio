// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PostsDetailModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostsDetailModel _$PostsDetailModelFromJson(Map<String, dynamic> json) {
  return PostsDetailModel(
    json['ifFollowed'] as bool,
    json['ifLegal'] as bool,
    json['ifLoved'] as bool,
    json['ifMuted'] as bool,
    json['lovedTimes'] as String,
    (json['myReplies'] as List)
        ?.map((e) =>
            e == null ? null : RepliesModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    (json['pics'] as List)
        ?.map((e) =>
            e == null ? null : PostPicModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['readCount'] as String,
    json['repliesCount'] as String,
    json['result'] == null
        ? null
        : PostsModel.fromJson(json['result'] as Map<String, dynamic>),
    json['shareCount'] as String,
  );
}

Map<String, dynamic> _$PostsDetailModelToJson(PostsDetailModel instance) =>
    <String, dynamic>{
      'result': instance.result,
      'pics': instance.pics,
      'ifLoved': instance.ifLoved,
      'repliesCount': instance.repliesCount,
      'lovedTimes': instance.lovedTimes,
      'myReplies': instance.myReplies,
      'ifFollowed': instance.ifFollowed,
      'readCount': instance.readCount,
      'ifLegal': instance.ifLegal,
      'shareCount': instance.shareCount,
      'ifMuted': instance.ifMuted,
    };
