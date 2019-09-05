import 'package:flutter/material.dart';
import 'package:my_app/stores/postsGallery.dart';
import 'package:toast/toast.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'stores/userStore.dart';
import 'package:http/http.dart' as http;
import 'stores/constValue.dart';
import 'routers.dart';

double rpx=0;
void main() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('urlPath', '10.0.2.2');
  prefs.setString('scheme', 'http');
  prefs.setInt('ports', 5000);
  // var rpx=MediaQuery.of(context).size.width/750;
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserProvider>(
        builder: (context) => UserProvider(),
      ),
      ChangeNotifierProvider<ConstValueProvider>(
          builder: (context) => ConstValueProvider()),
          
          ChangeNotifierProvider<PostsGalleryProvider>(builder: (context) =>PostsGalleryProvider())
    ],
    child: MaterialApp(
      home: MyApp(),
    ),
  ));
}

Future getLoginResponse() async {
  final prefs = await SharedPreferences.getInstance();
  UserInfo user = UserInfo("aaa", "bbb");
  String host = prefs.get('urlPath');
  Uri url = Uri(
      scheme: "http",
      host: host,
      port: 5000,
      // queryParameters: {"userAccount": user.userAccount, "pwd": user.pwd},
      // path: "/user/userLogin"
      path: "posts/getToken");
  final response = await http.get(url);
  if (response.statusCode == 200) {
    var a = response.body;
  } else {
    print('failed');
  }

  // var a=result.body;
}

class UserInput extends StatelessWidget {
  const UserInput({Key key, this.title, this.ifSecure, this.param})
      : super(key: key);
  final String title;
  final bool ifSecure;
  final String param;
  @override
  Widget build(BuildContext context) {
    final userInput = Provider.of<UserProvider>(context);
    return TextField(
      decoration: InputDecoration(
        hintText: title,
      ),
      obscureText: ifSecure,
      onChanged: (text) {
        userInput.setUserAcc(text);
        Toast.show(userInput.userAcc, context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.CENTER);
      },
    );
  }
}

class HeadOption extends StatelessWidget {
  const HeadOption({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text(
                        '确认退出？',
                      ),
                      children: <Widget>[
                        SimpleDialogOption(
                          child: Text('Yes'),
                          onPressed: () {
                            Toast.show('Clicked Yes', context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.CENTER);
                            Navigator.pop(context);
                          },
                        ),
                        SimpleDialogOption(
                          child: Text('No'),
                          onPressed: () {
                            Toast.show('Clicked No', context,
                                duration: Toast.LENGTH_SHORT,
                                gravity: Toast.CENTER);
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}

class LoginBox extends StatelessWidget {
  const LoginBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
      padding: EdgeInsets.all(20.0),
      width: 300,
      height: 180,
      decoration: BoxDecoration(
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
              // color: Color(0xffff0000),
              spreadRadius: 1.0,
              blurRadius: 5.0
              // offset: Offset(3.0, 3.0),
              ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 10,
          ),
          UserInput(
            ifSecure: false,
            title: '账号',
            param: "account",
          ),
          TextField(
            decoration: InputDecoration(hintText: '密码'),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}

class LoginBtnBar extends StatelessWidget {
  const LoginBtnBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
      width: 100,
      height: 40,
      alignment: Alignment.bottomRight,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(),
            flex: 5,
          ),
          Expanded(
            flex: 4,
            child: FlatButton(
              onPressed: () {},
              child: Text(
                '忘记密码',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              textColor: Colors.white,
            ),
          ),
          Expanded(
            flex: 3,
            child: FlatButton(
              onPressed: () {
                Navigator.push(context, Routers(rpx: rpx).generateRoute(RouteSettings(name: '/posts')));
              },
              child: Text(
                '登录',
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColor),
              ),
              textColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class OtherLogin extends StatelessWidget {
  const OtherLogin({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: <Widget>[
          Text(
            '选择其他登录方式',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(),
                flex: 1,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerRight,
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('images/wechat-logo.png'),
                        backgroundColor: Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      width: 60,
                      height: 60,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('images/weibo_logo.png'),
                        backgroundColor: Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(),
                flex: 1,
              ),
            ],
          )
        ],
      ),
    );
  }
}

// getRpx(context) {
//   double rpx = MediaQuery.of(context).size.width / 750;
//   return rpx;
// }

class LogoImage extends StatelessWidget {
  const LogoImage({Key key, this.rpx}) : super(key: key);
  final double rpx;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Image.asset(
          'images/cat_logo.png',
          fit: BoxFit.fitHeight,
          width: 750 * rpx,
          height: 250 * rpx,
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.instance=ScreenUtil(width:750,height: MediaQuery.of(context).size.width/750*MediaQuery.of(context).size.height)..init(context);
    // var rpx = getRpx(context);
    Future.delayed(Duration(milliseconds: 200)).then((e) {
      Provider.of<ConstValueProvider>(context).setRpx(context);
    });
    rpx = Provider.of<ConstValueProvider>(context).rpx;
    return Container(
        child: Scaffold(
      // appBar: AppBar(title: Text('登录'),),
      body: ListView(
        children: [
          
          HeadOption(),
          LogoImage(
            rpx: rpx,
          ),
          LoginBox(),
          LoginBtnBar(),
          Container(
            margin: EdgeInsets.fromLTRB(40, 20, 40, 0),
            child: Divider(),
          ),
          OtherLogin()
        ],
      ),
    ));
  }
}
