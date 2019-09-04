import 'package:flutter/material.dart';
import 'package:my_app/main.dart';

class Routers{
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name){
      case "/":
        return MaterialPageRoute(builder: (_)=>MyApp());
      // case "/posts":
      //   return MaterialPageRoute(builder: (_)=>)
    }
  }
}