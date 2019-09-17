import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/models/PostsModel.dart';
import 'package:my_app/models/headInfo.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_app/stores/postsGallery.dart';
import 'package:provider/provider.dart';

class ReCommendPage extends StatelessWidget {
  const ReCommendPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(builder: (context) => PostsGalleryProvider()),
        ],
        child: SingleChildScrollView(
          child: HeadBar(),
        ));
  }
}

class HeadBar extends StatefulWidget {
  HeadBar({Key key}) : super(key: key);

  _HeadBarState createState() => _HeadBarState();
}

class _HeadBarState extends State<HeadBar> {
  double rpx = 0.0;
  List<HeadInfo> heads = List<HeadInfo>();
  ScrollController scrollController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController = ScrollController();
    HeadInfo head = HeadInfo();
    head.avatarUrl =
        "https://pic2.zhimg.com/v2-a88cd7618933272ca681f86398e6240d_xl.jpg";
    head.ifFollowed = Random(1).nextBool();
    head.userName = "马友发";
    for (int i = 0; i <= 10; i++) {
      heads.add(head);
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Container();

    rpx = MediaQuery.of(context).size.width / 750;
    List<String> imgList = [
      "images/nafeng.jpg",
      "images/woman.jpg",
      "images/namecard.jpg"
    ];
    return Column(children: [
      SizedBox(
        height: 20 * rpx,
      ),
      SizedBox(
          width: 750 * rpx,
          height: 350 * rpx,
          child: Swiper(
            containerWidth: 750 * rpx,
            containerHeight: 350 * rpx,
            itemBuilder: (context, index) {
              return Image.asset(
                imgList[index],
                fit: BoxFit.fitWidth,
              );
            },
            itemCount: 3,
            viewportFraction: 0.8,
            scale: 0.9,
          )),
      Container(
          height: 140 * rpx,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: heads.length,
            itemBuilder: (context, index) {
              return drawHeadInfo(heads[index], rpx);
            },
          )),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: [genPiclist(0, context, scrollController)],
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [genPiclist(1, context, scrollController)],
            ),
          )
        ],
      )
    ]);
  }
}

genPiclist(int idx, BuildContext context, ScrollController scrollController) {
  var provider = Provider.of<PostsGalleryProvider>(context);
  var host = "http://www.guojio.com";
  List<PostsModel> postsList;
  double rpx = MediaQuery.of(context).size.width / 750;

  if (idx == 0) {
    postsList = provider.model1;
  } else {
    postsList = provider.model2;
  }
  if (postsList.length > 0) {
    return ListView.builder(
      itemCount: postsList.length,
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            Image.network(
              "${host + postsList[index].postsPics}",
              fit: BoxFit.fitWidth,
              width: 360 * rpx,
              height: 360 * postsList[index].picsRate * rpx,
            ),
            ListTile(
              title: Text(
                "${postsList[index].postsContent}",
                style: TextStyle(fontSize: 25*rpx,fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              subtitle: Row(
                children: [
                  Flexible(
                    flex:3,
                    fit: FlexFit.tight,
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          width: 40*rpx,
                          height: 40*rpx,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(postsList[index].makerPhoto),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10*rpx),
                            child: Text(
                              postsList[index].postsMaker,
                              style: TextStyle(fontSize: 22*rpx),
                              overflow: TextOverflow.ellipsis,
                              
                            )
                          )
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment:  MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(icon: Icon(Icons.favorite),onPressed: (){},color: Colors.redAccent,splashColor: Colors.transparent,),
                        Text(postsList[index].postsLoved.toString())
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        );
      },
      shrinkWrap: true,
    );
  } else {
    // List<Container> result=List<Container>();
    // result.add(Container());
    // return result;
    return Container();
  }
}

Widget drawHeadInfo(HeadInfo head, double rpx) {
  return Container(
    alignment: Alignment.center,
    width: 100 * rpx,
    height: 140 * rpx,
    child: Column(
      children: [
        Flexible(
          flex: 10,
          child: Container(
            padding: EdgeInsets.all(15 * rpx),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                head.avatarUrl,
              ),
              radius: 35 * rpx,
              child: Stack(
                fit: StackFit.loose,
                children: <Widget>[
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 5 * rpx,
                      child: Container(
                        width: 5 * rpx,
                        height: 5 * rpx,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Flexible(
            flex: 4,
            child: Container(
                alignment: Alignment.center,
                height: 40 * rpx,
                child: Text(
                  head.userName,
                  style: TextStyle(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                )))
      ],
    ),
  );
}

Widget drawSepList(List<PostsModel> list, double rpx) {
  return ListView.builder(
    itemBuilder: (context, index) {
      return Container(
          padding: EdgeInsets.all(5 * rpx),
          child: ListTile(
            title: Image.network(
              list[index].postsPics,
              fit: BoxFit.fitWidth,
            ),
          ));
    },
  );
}
