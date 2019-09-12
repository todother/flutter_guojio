import 'package:flutter/material.dart';
import 'pages/recommendPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '果Jio',
      home: RecommendPage(),
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
          IconButton(icon:Icon(Icons.search),onPressed: (){},),
        ],
        leading: IconButton(icon: Icon(Icons.view_headline), onPressed: () {}),
        title: Container(
            width: 400 * rpx,
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
          Container(child:ReCommendPage()
          ),
          Container(
            child: Text('this is 2'),
          ),
        ],
      ),
    );
  }
}
