import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'pages/recommendPage.dart';

class Routers extends Object {
  Routers({Key key,this.rpx});
  final double rpx;
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder: (_)=>MyApp());
        break;
      case "/posts":
        return MaterialPageRoute(builder: (_)=>ReCommendPage());
        break;
      default:
        return MaterialPageRoute(builder: (_)=>Text('this is not router like this'));
        break;
    }
  }
}