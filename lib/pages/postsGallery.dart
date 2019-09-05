import 'package:flutter/material.dart';
import 'package:my_app/main.dart';
import 'package:my_app/models/PostsModel.dart';
import 'package:my_app/stores/postsGallery.dart';
import 'package:my_app/tools/Ajax.dart';
import 'package:provider/provider.dart';
// import '../routers.dart';
import '../stores/constValue.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future getPosts(orderType, ifRefresh, context) async {
  Uri url = await Ajax().generate('posts/getPosts', {
    "openId": "***",
    "dataFrom": "0",
    "count": "30",
    "refreshTime": "2019/09/05 00:00:00",
    "currentSel": "1",
    "ulo": "0",
    "ula": "0"
  });
  // final
  final response = await http.get(url);
  if (response.statusCode == 200) {
    Provider.of<PostsGalleryProvider>(context).setGalleryModel(response.body);
  }
}

class OrderOptionBtn extends StatelessWidget {
  const OrderOptionBtn({Key key, this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    // return Container(
    //   child: child,
    // );
  }
}

class HeadBar extends StatelessWidget {
  const HeadBar({Key key}) : super(key: key);
  // BuildContext context;
  // ()=>getPosts(0, 0, context);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: FlatButton(
                      child: Text('最热'),
                      onPressed: () {},
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: FlatButton(
                      child: Text('最新'),
                      onPressed: () {},
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    child: FlatButton(
                      child: Text('关注'),
                      onPressed: () {},
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.fromLTRB(20 * rpx, 20 * rpx, 80 * rpx, 0),
          padding: EdgeInsets.fromLTRB(0 * rpx, 0, 0, 10 * rpx),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20 * rpx),
              color: Colors.grey[300]),
          height: 80 * rpx,
          child: Row(
            children: <Widget>[
              IconButton(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10 * rpx),
                icon: Icon(
                  Icons.search,
                  size: (60 * rpx),
                  color: Colors.grey[800],
                ),
                onPressed: () {},
              ),
              Expanded(
                  child: TextFormField(
                decoration: InputDecoration.collapsed(
                  hintText: "搜索点有意思的",
                ),
                style: TextStyle(height: 1.6),
              )),
            ],
          )),
    );
  }
}

class PostsGallery extends StatelessWidget {
  const PostsGallery(
      {Key key,
      String openId,
      DateTime now,
      int orderType,
      double rpx,
      BuildContext con})
      : super(key: key);
  // final double rpx;

  @override
  Widget build(BuildContext context) {
    List<PostsModel> model = List<PostsModel>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ConstValueProvider>(
            builder: (context) => ConstValueProvider()),
        ChangeNotifierProvider<PostsGalleryProvider>(builder: (context) {
          getPosts(0, 0, context);
          Future.delayed(Duration(milliseconds: 200),(){model = Provider.of<PostsGalleryProvider>(context).models;});
          
          return PostsGalleryProvider();
        }),
      ],
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250 * rpx,
            floating: false,
            title: Text('this is title'),
          ),
          SliverList(
              delegate:
                  SliverChildBuilderDelegate((context, index) => Text(model[index].postsContent),childCount: model.length)),
                  
        ],
      ),
    );
  }
}
