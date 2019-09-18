// import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class ConstValueProvider with ChangeNotifier{
  double _rpx=0;
  String pic_Server="http://www.guojio.com";

  get rpx=>_rpx;

  setRpx(context){
    // double ratio=MediaQuery.of(context).size.width/750;
    // _rpx=ratio;
    pic_Server="http://www.guojio.com";
    notifyListeners();
  }
}