import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/models/PostsModel.dart';
import 'package:my_app/tools/Ajax.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class PostsGalleryProvider with ChangeNotifier {
  List<PostsModel> _model1 = List<PostsModel>();
  List<PostsModel> _model2 = List<PostsModel>();
  double _len1=0;
  double _len2=0;
  get models1 => _model1;
  get models2 => _model2;


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
    for(var item in result){
      if(_len1>=_len2){
        _model1.add(item);
        _len1+=item.picsRate;
      }
      else{
        _model2.add(item);
        _len2+=item.picsRate;
      }
    }
    notifyListeners();
  }
}
