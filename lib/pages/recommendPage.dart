import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_app/models/headInfo.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class ReCommendPage extends StatelessWidget {
  const ReCommendPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HeadBar(),
    );
  }
}

class HeadBar extends StatefulWidget {
  HeadBar({Key key}) : super(key: key);

  _HeadBarState createState() => _HeadBarState();
}

class _HeadBarState extends State<HeadBar> {
  double rpx = 0.0;
  List<HeadInfo> heads = List<HeadInfo>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      Swiper(
        containerWidth: 750 * rpx,
        containerHeight: 350 * rpx,
        itemBuilder: (context, index) {
          return Image.network(
            imgList[index],
            fit: BoxFit.fitWidth,
          );
        },
        itemCount: 3,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
      Container(
          height: 140 * rpx,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: heads.length,
            itemBuilder: (context, index) {
              return drawHeadInfo(heads[index], rpx);
            },
          ))
    ]);
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

Widget drawSwiperList(double rpx) {
  List<String> imgList = [
    "images/nafeng.jpg",
    "images/woman.jpg",
    "images/namecard.jpg"
  ];
  return Swiper(
    containerWidth: 750 * rpx,
    containerHeight: 350 * rpx,
    itemBuilder: (context, index) {
      return Image.network(
        imgList[index],
        fit: BoxFit.fitWidth,
      );
    },
    itemCount: 3,
    viewportFraction: 0.8,
    scale: 0.9,
  );
}
