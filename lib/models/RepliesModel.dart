import 'package:json_annotation/json_annotation.dart';

part 'RepliesModel.g.dart';
@JsonSerializable()
class RepliesModel {
  String replyMaker;
  String nickName;
  String avantarUrl;
  String replyId;
  String replyContent;
  bool replyLoved;
  String postsId;
  int lovedCount;
  List<RepliesModel> afterReplyList = new List<RepliesModel>();
  int afterReplyCount;
  DateTime afterReplyDate;
  String replyToUser;
  bool isAdmin;
  RepliesModel(this.afterReplyCount,this.afterReplyDate,this.afterReplyList,this.avantarUrl,this.isAdmin,this.lovedCount,this.nickName,this.postsId,this.replyContent,this.replyId
  ,this.replyLoved,this.replyMaker,this.replyToUser);

      factory RepliesModel.fromJson(Map<String, dynamic> json) =>
      _$RepliesModelFromJson(json);
  Map<String, dynamic> toJson() => _$RepliesModelToJson(this);
}
