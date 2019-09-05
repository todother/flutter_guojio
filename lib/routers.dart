import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'pages/postsGallery.dart';

class Routers extends Object {
  Routers({Key key,this.rpx});
  final double rpx;
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder: (_)=>MyApp());
        break;
      case "/posts":
        return MaterialPageRoute(builder: (_)=>PostsGallery(now: DateTime.now(),openId: '',orderType: 1,rpx: rpx,));
        break;
      default:
        return MaterialPageRoute(builder: (_)=>Text('this is not router like this'));
        break;
    }
  }
}