
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class Ajax extends Object {
  // 
  Future<Uri> generate(String path, Map<String,dynamic> params) async{
    final prefs = await SharedPreferences.getInstance();
    String hosts=prefs.get('urlPath');
    String scheme=prefs.get('scheme');
    int ports=prefs.get('ports');
    Uri url = Uri(
      scheme: scheme,
      host: hosts,
      port: ports,
      path: path,
      queryParameters: params);
    return url;
  }
  
}