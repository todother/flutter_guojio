import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/PostsModel.dart';
import 'package:my_app/tools/Ajax.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PostsGalleryProvider with ChangeNotifier {
  List<PostsModel> _model = List<PostsModel>();
  get models => _model;


//   Future getPosts(orderType, ifRefresh) async {
//   Uri url = await Ajax().generate('posts/getPosts', {
//     "openId": "ol_BV43dgg71nfDiCgeBD8OHNQQ0",
//     "dataFrom": "0",
//     "count": "30",
//     "refreshTime": "2019/09/05 00:00:00",
//     "currentSel": "1",
//     "ulo": "0",
//     "ula": "0"
//   });
//   // final
//   final response = await http.get(url);
//   if (response.statusCode == 200) {
//     // Provider.of<PostsGalleryProvider>(context)
//         // .setGalleryModel(response.body);
//   }
// }


  setGalleryModel(String items) {
    var result=List<PostsModel>();

    var posts = json.decode(items)["result"];
    // result.add(posts);

    for(var item in posts){
      result.add(PostsModel.fromJson(item));
    }
    notifyListeners();
  }
}
