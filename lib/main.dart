
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:my_app/stores/constValue.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'pages/recommendPage.dart';

Future main() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();
  // String hosts = prefs.get('urlPath');
  // String scheme = prefs.get('scheme');
  // int ports = prefs.get('ports');
  prefs.setBool("ifIOS", Platform.isIOS);
  prefs.setBool("ifPrd", false);
  prefs.setBool("ifReal_d", true);

  prefs.setString("urlPath_real_d", "192.168.0.8");
  prefs.setString("scheme_real_d", "http");
  prefs.setInt("ports_real_d", 5000);

  prefs.setString("urlPath_ios_d", "127.0.0.1");
  prefs.setString("scheme_ios_d", "http");
  prefs.setInt("ports_ios_d", 5000);

  prefs.setString("urlPath_and_d", "10.0.2.2");
  prefs.setString("scheme_and_d", "http");
  prefs.setInt("ports_and_d", 5000);

  prefs.setString("urlPath_p", "118.26.177.76");
  prefs.setString("scheme_p", "http");
  prefs.setInt("ports_p", 80);

  prefs.setString("picServer", "http://www.guojio.com");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '果Jio',
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (context)=>ConstValueProvider(),)
        ],
        child: RecommendPage(),
      ),
    );
  }
}

class RecommendPage extends StatefulWidget {
  RecommendPage({Key key}) : super(key: key);

  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with SingleTickerProviderStateMixin {
  double rpx = 0.0;
  TabController _tabController;
  int index = 1;
  void _handleChange() {
    if (index != _tabController.index) {
      setState(() {
        index = _tabController.index;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: index);
    ConstValueProvider provider=ConstValueProvider();
    provider.setRpx(context);

    _tabController.addListener(_handleChange);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    rpx = MediaQuery.of(context).size.width / 750;
    double bigText = 35 * rpx;
    double smlText = 25 * rpx;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        leading: IconButton(icon: Icon(Icons.view_headline), onPressed: () {}),
        title: Container(
            width: 450 * rpx,
            child: TabBar(
              labelStyle: TextStyle(fontSize: bigText),
              unselectedLabelStyle: TextStyle(fontSize: smlText),
              indicatorColor: Colors.white,
              unselectedLabelColor: Colors.white,
              labelColor: Colors.white,
              indicatorWeight: 2,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 40 * rpx),
              controller: _tabController,
              tabs: <Widget>[
                Tab(
                    child: Text(
                  "关注",
                )),
                Tab(
                    child: Text(
                  "推荐",
                )),
                Tab(
                    child: Text(
                  "热榜",
                ))
              ],
            )),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Container(
            child: Text('this is 0'),
          ),
          Container(child: ReCommendPage()),
          Container(
            child: Text('this is 2'),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (i){
          print(i);
        },
        items: [
        
        BottomNavigationBarItem(icon: Icon(Icons.home),title: Text("home")),
        BottomNavigationBarItem(icon: Icon(Icons.camera_enhance),title: Text("camera")),
        BottomNavigationBarItem(icon: Icon(Icons.verified_user),title: Text("user")),
      ],),
    );
  }
}
