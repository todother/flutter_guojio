// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RepliesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RepliesModel _$RepliesModelFromJson(Map<String, dynamic> json) {
  return RepliesModel(
    json['afterReplyCount'] as int,
    json['afterReplyDate'] == null
        ? null
        : DateTime.parse(json['afterReplyDate'] as String),
    (json['afterReplyList'] as List)
        ?.map((e) =>
            e == null ? null : RepliesModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['avantarUrl'] as String,
    json['isAdmin'] as bool,
    json['lovedCount'] as int,
    json['nickName'] as String,
    json['postsId'] as String,
    json['replyContent'] as String,
    json['replyId'] as String,
    json['replyLoved'] as bool,
    json['replyMaker'] as String,
    json['replyToUser'] as String,
  );
}

Map<String, dynamic> _$RepliesModelToJson(RepliesModel instance) =>
    <String, dynamic>{
      'replyMaker': instance.replyMaker,
      'nickName': instance.nickName,
      'avantarUrl': instance.avantarUrl,
      'replyId': instance.replyId,
      'replyContent': instance.replyContent,
      'replyLoved': instance.replyLoved,
      'postsId': instance.postsId,
      'lovedCount': instance.lovedCount,
      'afterReplyList': instance.afterReplyList,
      'afterReplyCount': instance.afterReplyCount,
      'afterReplyDate': instance.afterReplyDate?.toIso8601String(),
      'replyToUser': instance.replyToUser,
      'isAdmin': instance.isAdmin,
    };
