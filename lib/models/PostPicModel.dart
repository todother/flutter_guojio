import 'package:json_annotation/json_annotation.dart';

part 'PostPicModel.g.dart';

@JsonSerializable()
class PostPicModel {
  String picID;
  String postsID;

  String picPath;

  int picIndex;

  String picSimpPath;

  double picsRate;
  PostPicModel(this.picID, this.picIndex, this.picPath, this.picSimpPath,
      this.picsRate, this.postsID);

  factory PostPicModel.fromJson(Map<String, dynamic> json) =>
      _$PostPicModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostPicModelToJson(this);
}
