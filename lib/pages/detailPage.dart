import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_app/models/PostPicModel.dart';
import 'package:my_app/models/PostsDetailModel.dart';
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
                    onPressed: () {},
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
    return AnimatedContainer(
      height: 110 * rpx + tobottom,
      padding: EdgeInsets.only(bottom: tobottom),
      duration: Duration(milliseconds: 100),
      child: Container(
          color: Colors.grey[50],
          child: BottomAppBar(
            // elevation: 20,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 20 * rpx,
                ),
                Container(
                    alignment: Alignment.center,
                    margin:
                        EdgeInsets.fromLTRB(20 * rpx, 15 * rpx, 0, 20 * rpx),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40 * rpx),
                        color: Colors.grey[300]),
                    width: tobottom == 0 ? 240 * rpx : 560 * rpx,
                    // height: 80 * rpx,
                    child: Container(
                        height: 70 * rpx,
                        child: TextField(
                          // textAlignVertical: TextAlignVertical(y:0.5),
                          controller: _textController,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              height: 1,
                              textBaseline: TextBaseline.ideographic),

                          decoration: InputDecoration(
                              hintText: "说点什么",
                              border: InputBorder.none,
                              icon: Icon(
                                Icons.create,
                                size: 45 * rpx,
                                color: Colors.grey[400],
                              )),
                        ))),
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
