import '../models/userModel.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:flutter/material.dart';
export '../models/userModel.dart';
import 'package:provider/provider.dart';


class UserProvider with ChangeNotifier{
  // UserStore(String userAccount, String pwd) : super(userAccount, pwd);
  UserInfo _user=UserInfo("", "");

 
  get userAcc=>_user.userAccount;
  get pwd=>_user.pwd;

  setUserAcc(userAcc){
    _user.userAccount=userAcc;
    notifyListeners();
  }

  setPwd(password){
    _user.pwd=password;
    notifyListeners();
  }

}

class UserStore{
  static BuildContext context;

  static init({context,child}){
    return MultiProvider(providers: [
      ChangeNotifierProvider(builder: (_)=>UserProvider(),),
      // ChangeNotifierProvider(builder: (_)=>UserProvider(),),
    ],
    child: child,);
  }

  static Consumer connect<T>({builder,value,child}) {
    return Consumer<T>(builder: builder,child: child);
  }
}

