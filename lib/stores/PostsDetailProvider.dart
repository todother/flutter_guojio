
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/PostsDetailModel.dart';
import 'package:my_app/tools/Ajax.dart';
import 'package:http/http.dart' as http;

class PostsDetailProvider with ChangeNotifier{
  PostsDetailModel result;
  String _postsId;
  String _openId;
  String _userId;
  bool autoFocus=false;

  FocusNode focusNode=FocusNode();
  ScrollController controller=ScrollController();
  PostsDetailProvider(String openId,String userId,String postsId )  {
    _postsId=postsId;
    _openId=openId;
    userId=userId;
    getRenderData(openId,userId,postsId);
  }

  setFocus(){
    autoFocus=!autoFocus;
    notifyListeners();
  }

  getRenderData(String openId,String userId, String postsId) async {
    Uri url=await Ajax().generate("posts/getPostsDetail", {
      "openId":openId,
      "userId":userId,
      "from":0.toString(),
      "count":30.toString(),
      "refreshTime":DateTime.now().toString(),
      "postsId":postsId
    });
    var response=await http.get(url);
    PostsDetailModel model=PostsDetailModel.fromJson(json.decode( response.body));
    result=model;
    notifyListeners();
    return model;
  }
}