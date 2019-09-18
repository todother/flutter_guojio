import 'package:json_annotation/json_annotation.dart';
import 'package:my_app/models/PostPicModel.dart';
import 'package:my_app/models/RepliesModel.dart';

import 'PostsModel.dart';


part 'PostsDetailModel.g.dart';
@JsonSerializable()
class PostsDetailModel {
  PostsModel result;
  List<PostPicModel> pics;
  bool ifLoved;
  String repliesCount;
  String lovedTimes;
  List<RepliesModel> myReplies;
  bool ifFollowed;
  String readCount;
  bool ifLegal;
  String shareCount;
  bool ifMuted;
  PostsDetailModel(this.ifFollowed,this.ifLegal,this.ifLoved,this.ifMuted,this.lovedTimes,this.myReplies,this.pics,
  this.readCount,this.repliesCount,this.result,this.shareCount);

    factory PostsDetailModel.fromJson(Map<String, dynamic> json) =>
      _$PostsDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostsDetailModelToJson(this);
}


