import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_app/models/PostPicModel.dart';
import 'package:my_app/models/PostsDetailModel.dart';
import 'package:my_app/models/RepliesModel.dart';
import 'package:my_app/stores/PostsDetailProvider.dart';
import 'package:my_app/stores/constValue.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_page_indicator/flutter_page_indicator.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key key, this.openId, this.makerId, this.postsId})
      : super(key: key);
  final String openId;
  final String makerId;
  final String postsId;

  @override
  Widget build(BuildContext context) {
    print(postsId);
    bool ifReady = false;
    return Container(
      child: genDetailPage(context),
      //genDetailPage(context)
    );
  }
}

genDetailPage(BuildContext context) {
  // var provider=Provider.of<PostsDetailProvider>(context);
  if (Provider.of<PostsDetailProvider>(context) != null &&
      Provider.of<PostsDetailProvider>(context).result != null) {
    PostsDetailModel data = Provider.of<PostsDetailProvider>(context).result;
    String pic_Server = Provider.of<ConstValueProvider>(context).pic_Server;
    double rpx = MediaQuery.of(context).size.width / 750;
    ScrollController controller = ScrollController();
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          child: Row(
            children: [
              Container(
                width: 30,
                height: 30,
                child: CircleAvatar(
                    backgroundImage: NetworkImage(
                  data.result.makerPhoto,
                )),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Text(
                "${data.result.postsMaker}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                overflow: TextOverflow.ellipsis,
              ))
            ],
          ),
        ),
        actions: <Widget>[
          Container(
              padding: EdgeInsets.all(22 * rpx),
              child: Container(
                  width: 130 * rpx,
                  child: OutlineButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(44 * rpx),
                    ),
                    textColor: Colors.white,
                    borderSide: BorderSide(color: Colors.white, width: 1.5),
                    onPressed: () {
                      showModalBottomSheet(context: context,builder: (context){return genBtmSheet(context);});
                      },
                    child: Text("关注"),
                  ))),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          )
        ],
      ),
      body: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
              controller: controller,
              child: Column(
                children: [
                  AniSwiper(
                      picRate: data.pics[0].picsRate,
                      pics: data.pics,
                      pic_Server: pic_Server),
                  SizedBox(
                    height: 20 * rpx,
                  ),
                  ListTile(
                      subtitle: Text(
                    data.result.postsContent,
                  )),
                  Divider(
                    indent: 20 * rpx,
                    endIndent: 20 * rpx,
                  ),
                  ReplyContent(controller: controller)
                ],
              ))),
      bottomNavigationBar: AniBottomBar(),
    );
  } else {
    return Scaffold();
  }
}

genTopSwiper(
    BuildContext ctx, List<PostPicModel> pics, String picServer) async {
  int curIdx = 0;
  AnimatedContainer(
      duration: Duration(milliseconds: 300),
      child: Swiper(
        itemCount: pics.length,
        onIndexChanged: (idx) {},
        itemBuilder: (context, int i) {
          return Image.network("${pics[i].picPath}");
        },
      ));
}

class AniSwiper extends StatefulWidget {
  AniSwiper(
      {Key key,
      @required this.picRate,
      @required this.pics,
      @required this.pic_Server})
      : super(key: key);
  final double picRate;
  final List<PostPicModel> pics;
  final String pic_Server;
  _AniSwiperState createState() => _AniSwiperState();
}

class _AniSwiperState extends State<AniSwiper> {
  double height;
  double width;
  double picRate;
  List<PostPicModel> pics;
  int curIdx;
  String picServer;
  var fitType;

  @override
  void initState() {
    // TODO: implement initState
    picRate = widget.picRate >= 1.2 ? 1.2 : widget.picRate;
    pics = widget.pics;
    curIdx = 0;
    picServer = widget.pic_Server;
    fitType = picRate == 1.2 ? BoxFit.fitWidth : BoxFit.fitHeight;
    // picServer=Provider.of<ConstValueProvider>(context).pic_Server;
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = width * picRate;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      alignment: Alignment.topCenter,
      width: width,
      height: height,
      child: Swiper(
        indicatorLayout: PageIndicatorLayout.WARM,
        pagination: SwiperPagination(),
        controller: SwiperController(),
        loop: false,
        duration: 300,
        itemCount: pics.length,
        onIndexChanged: (idx) {
          setState(() {
            curIdx = idx;
            // fitType=picRate==1.2?BoxFit.fitWidth:BoxFit.fitHeight;
            picRate =
                pics[curIdx].picsRate >= 1.2 ? 1.2 : pics[curIdx].picsRate;
            fitType = picRate == 1.2 ? BoxFit.fitWidth : BoxFit.fitHeight;
          });
        },
        itemBuilder: (context, int i) {
          return Image.network(
            "$picServer${pics[i].picPath}",
            fit: fitType,
          );
        },
      ),
    );
  }
}

class AniBottomBar extends StatefulWidget {
  AniBottomBar({Key key}) : super(key: key);

  _AniBottomBarState createState() => _AniBottomBarState();
}

class _AniBottomBarState extends State<AniBottomBar> {
  TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double rpx = MediaQuery.of(context).size.width / 750;
    double tobottom = MediaQuery.of(context).viewInsets.bottom;
    PostsDetailProvider provider = Provider.of<PostsDetailProvider>(context);
    return AnimatedContainer(
      height: 110 * rpx + tobottom,
      padding: EdgeInsets.only(bottom: tobottom),
      duration: Duration(milliseconds: 100),
      child: Container(
          color: Colors.grey[50],
          child: BottomAppBar(
            child: Row(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 20 * rpx),
                    margin:
                        EdgeInsets.fromLTRB(20 * rpx, 15 * rpx, 0, 15 * rpx),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30 * rpx),
                        color: Colors.grey[200]),
                    width: tobottom == 0 ? 240 * rpx : 560 * rpx,
                    child: TextField(
                      focusNode: provider.focusNode,
                      controller: _textController,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          hintText: "说点什么",
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.create,
                            size: 40 * rpx,
                            color: Colors.grey[500],
                          )),
                    )),
                tobottom == 0
                    ? Expanded(
                        child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          genSizedIconBtn(
                              Icon(Icons.favorite), "123", () {}, rpx),
                          genSizedIconBtn(
                              Icon(Icons.reply_all), "123", () {}, rpx),
                          genSizedIconBtn(
                              Icon(Icons.star_border), "123", () {}, rpx),
                          SizedBox(
                            width: 20 * rpx,
                          )
                        ],
                      ))
                    : Container(
                        width: 150 * rpx,
                        alignment: Alignment.center,
                        child: FlatButton(
                          onPressed: () {},
                          child: Text("提交"),
                        ),
                      )
              ],
            ),
          )),
    );
  }
}

genSizedIconBtn(Icon icon, String text, Function tapFunc, double rpx) {
  return Row(children: [
    SizedBox(
      width: 50 * rpx,
      child: IconButton(
        icon: icon,
        onPressed: () {
          tapFunc();
        },
      ),
    ),
    SizedBox(
      width: 20 * rpx,
    ),
    Text(text)
  ]);
}

class ReplyContent extends StatelessWidget {
  const ReplyContent({Key key, this.controller}) : super(key: key);
  final ScrollController controller;
  @override
  Widget build(BuildContext context) {
    PostsDetailProvider provider = Provider.of<PostsDetailProvider>(context);
    double rpx = MediaQuery.of(context).size.width / 750;
    return Container(
      padding: EdgeInsets.all(10 * rpx),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20 * rpx),
            alignment: Alignment.centerLeft,
            child: Text(
              "共有 ${provider.result.repliesCount} 条评论",
              style: TextStyle(color: Colors.grey[700]),
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                    width: 45 * rpx,
                    height: 45 * rpx,
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(provider.result.result.makerPhoto),
                    )),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(40 * rpx)),
                    margin: EdgeInsets.only(left: 20 * rpx),
                    padding: EdgeInsets.only(left: 20 * rpx),
                    width: 620 * rpx,
                    height: 50 * rpx,
                    child: ConstrainedBox(
                        constraints: BoxConstraints(maxHeight: 50 * rpx),
                        child: TextField(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(provider.focusNode);
                          },
                          style: TextStyle(fontSize: 27 * rpx),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.create,
                              size: 30 * rpx,
                            ),
                            hintText: "说点好听的，让大家都快乐",
                            border: InputBorder.none,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 3),
                          ),
                        )))
              ],
            ),
            padding: EdgeInsets.all(20 * rpx),
          ),
          genRepliesList(provider.result.myReplies, rpx, controller)
        ],
      ),
    );
  }
}

genRepliesList(
    List<RepliesModel> replies, double rpx, ScrollController controller) {
  replies = replies.sublist(0, (replies.length > 10 ? 10 : replies.length));
  return ListView.builder(
      shrinkWrap: true,
      itemCount: replies.length,
      controller: controller,
      itemBuilder: (BuildContext context, int index) {
        RepliesModel curReplyRoot = replies[index];
        return (Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Container(
                margin: EdgeInsets.only(left: 10 * rpx, top: 20 * rpx),
                child: HeadAvatar(
                  url: replies[index].avantarUrl,
                  size: 50 * rpx,
                ),
              ),
            ),
            Flexible(
                flex: 9,
                fit: FlexFit.loose,
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        isThreeLine: true,
                        trailing: Container(
                            width: 80 * rpx,
                            alignment: Alignment.topCenter,
                            child: IconButton(
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {},
                            )),
                        title: Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizeText(
                              content: replies[index].nickName,
                              color: Colors.grey[400],
                              size: 24 * rpx,
                            ),
                            SizedBox(
                              width: 30 * rpx,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 80 * rpx,
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius:
                                      BorderRadius.circular(20 * rpx)),
                              child: Container(
                                padding: EdgeInsets.all(5 * rpx),
                                child: SizeText(
                                  content: "作者",
                                  size: 20 * rpx,
                                  color: Colors.grey[700],
                                ),
                              ),
                            )
                          ],
                        )),
                        subtitle: Row(
                          children: <Widget>[
                            Expanded(
                                child: SizeText(
                              content: curReplyRoot.replyContent,
                              size: 24 * rpx,
                              color: Colors.grey[700],
                            )),
                          ],
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: controller,
                          itemCount: curReplyRoot.afterReplyList.length >= 2
                              ? 2
                              : curReplyRoot.afterReplyList.length,
                          itemBuilder: (BuildContext context, int index) {
                            RepliesModel curAfterReply =
                                curReplyRoot.afterReplyList[index];
                            return ListTile(
                              leading: Container(
                                child: HeadAvatar(
                                  url: curAfterReply.avantarUrl,
                                  size: 40 * rpx,
                                ),
                              ),
                              title: Row(
                                children: <Widget>[
                                  SizeText(
                                    content: curAfterReply.nickName,
                                    size: 25 * rpx,
                                    color: Colors.grey[400],
                                  ),
                                  SizedBox(
                                    width: 30 * rpx,
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 80 * rpx,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius:
                                            BorderRadius.circular(20 * rpx)),
                                    child: Container(
                                      padding: EdgeInsets.all(5 * rpx),
                                      child: SizeText(
                                        content: "作者",
                                        size: 20 * rpx,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              subtitle: RichText(
                                  text: TextSpan(
                                      text:
                                          "回复@${curAfterReply.replyToUser}:${curAfterReply.replyContent}",
                                      style: TextStyle(
                                          fontSize: 25 * rpx,
                                          color: Colors.grey[700]),
                                      children: [
                                    TextSpan(
                                        text: "    今天 17：02",
                                        style: TextStyle(
                                            fontSize: 20 * rpx,
                                            color: Colors.grey[400]))
                                  ])),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: 7.5 * rpx,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.favorite_border),
                                      onPressed: () {},
                                    )
                                  ]),
                            );
                          },
                        ),
                      )
                    ]))
          ],
        ));
      });
}

class HeadAvatar extends StatelessWidget {
  const HeadAvatar({Key key, this.url, this.size}) : super(key: key);
  final String url;
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        child: CircleAvatar(
          backgroundImage: NetworkImage(url),
        ));
  }
}

class SizeText extends StatelessWidget {
  const SizeText({
    Key key,
    this.content,
    this.size,
    this.color,
  }) : super(key: key);
  final String content;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "$content",
        style: TextStyle(fontSize: size, color: color, height: 1.6),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

showBottomSheet(BuildContext context) {
  var list=List<Widget>();
  List.generate(20, (i)=>list.add(
    Container(
        height: 30,
            child: Text("this is $i"),
          )));

  return BottomSheet(onClosing: (){},builder: (context){
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 200),
      child: SingleChildScrollView(
        child: Column(children: list,)
      )
    );
  },);
}

genBtmSheet(context){
  var list=List<Widget>();
  List.generate(20, (i)=>list.add(
    Container(
        height: 30,
            child: Text("this is $i"),
          )));
  return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 200),
      child: SingleChildScrollView(
        child: Column(children: list,)
      )
    );
}

