import 'package:flutter/material.dart';

class OrderOptionBtn extends StatelessWidget {
  const OrderOptionBtn({Key key,this.text}) : super(key: key);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 3,child: Container(),),
                Expanded(flex: 2,child: Container(

                ),),
                Expanded(flex: 2,child: Container(),),
                Expanded(flex: 2,child: Container(),),
                Expanded(flex: 3,child: Container(),)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PostsGallery extends StatelessWidget {
  const PostsGallery({Key key,String openId,DateTime now,int orderType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

        ],
      ),
    );
  }
}