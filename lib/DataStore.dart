import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class DataStore with ChangeNotifier{
  String _account="";
  String _password="";
  
  get account=>_account;
  get password=>_password;

  set account(String acc){
    account=acc;
    notifyListeners();
  }

  changePwd(String pwd){
    _password=pwd;
    notifyListeners();
  }

}