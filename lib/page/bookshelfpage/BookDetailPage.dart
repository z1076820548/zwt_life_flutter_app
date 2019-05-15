import 'package:extended_image/extended_image.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/net/Code.dart';
import 'package:zwt_life_flutter_app/common/widgets/bookshelfwidget/ChipsTile.dart';
import 'package:zwt_life_flutter_app/common/widgets/searchwidget/hotSug.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/BookShelfPage.dart';
import 'package:zwt_life_flutter_app/public.dart';

class BookDetailPage extends StatefulWidget {
  static final String sName = "BookDetailPage";
  final String bookId;

  const BookDetailPage({Key key, this.bookId}) : super(key: key);

  @override
  _BookDetailPageState createState() {
    // TODO: implement createState
    return _BookDetailPageState();
  }
}

class _BookDetailPageState extends State<BookDetailPage> {
  BookShelfDbProvider bookShelfDbProvider = new BookShelfDbProvider();
  BookDetailBean bookDetailBean;
  TapGestureRecognizer tapRecognizer = new TapGestureRecognizer();
  bool noShowCollapseLongIntro = true;
  bool isCollect = false;



  @override
  void dispose() {
    myBanner.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(milliseconds: 0), () async {
      await initData();
    });
    super.initState();

    //富文本点击
    tapRecognizer.onTap = richTap;

    myBanner = BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: AdmobId.BannerId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event is $event");
      },
    );
    myBanner
    // typically this happens well before the ad is shown
      ..load()
      ..show(
        // Positions the banner ad 60 pixels from the bottom of the screen
        anchorOffset: 0,
        // Banner Position
        anchorType: AnchorType.bottom,
      );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('书籍详情'),
        elevation: 0,
        actions: <Widget>[
          Center(
              child: GestureDetector(
                onTap: () {
                  cacheBook();
                },
                child: Container(
                    padding: EdgeInsets.only(right: 10), child: Text('全本缓存')),
              ))
        ],
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: _buildView(),
        ),
      ),
    );
  }

  initData() async {
    Data res = await dioGetBookDetail(widget.bookId);
    if (res.data != null && res.result) {
      setState(() {
        bookDetailBean = res.data;
      });
    }
    List<RecommendBooks> list =
    await bookShelfDbProvider.getOneData(bookDetailBean.id);
    if (list != null && list.length != 0) {
      setState(() {
        isCollect = true;
      });
    }
  }

  //搜索作者
  void richTap() {
    NavigatorUtils.gotoBookByTagsPage(
        context, bookDetailBean.author.replaceAll(" ", ""), 'Author');
  }

  _buildView() {
    if (bookDetailBean == null) {
      return Container();
    }
    return Container(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: ExtendedImage.network(
                      (Constant.IMG_BASE_URL + bookDetailBean.cover),
                      height: ScreenUtil.getInstance().L(70),
                      fit: BoxFit.fitHeight,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      cache: true,
                      border: Border.all(color: Colors.black, width: 1.0),
                      shape: BoxShape.rectangle,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              bookDetailBean.title,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenUtil.getInstance().setSp(16)),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: Text.rich(TextSpan(children: [
                              TextSpan(
                                recognizer: tapRecognizer,
                                text: bookDetailBean.author,
                                style: TextStyle(
                                    color: Colors.red[800],
                                    fontSize: ScreenUtil.getInstance().setSp(12)),
                              ),
                              TextSpan(
                                text: ('  |  ' +
                                    bookDetailBean.cat +
                                    '  |  ' +
                                    FormatUtil.wordCount(bookDetailBean.wordCount)),
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: ScreenUtil.getInstance().setSp(12)),
                              ),
                            ])),
                          ),
                          Container(
                            child: Text(
                                (FormatUtil.getDescriptionTimeFromDateString(
                                    bookDetailBean.updated) +
                                    "更新"),
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: ScreenUtil.getInstance().setSp(12))),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            //以下是追更新 开始阅读 -------------------------------------------------------------------------------------------------------------------------------------------------------
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    child: Ink(
                      child: InkWell(
                        onTap: () => {joinCollection()},
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                          decoration: BoxDecoration(
                            border: new Border.all(color: Colors.black, width: 1),
                            // 边色与边宽度
                            borderRadius: new BorderRadius.circular((5.0)), // 圆角度
                          ),
                          child: isCollect
                              ? Text(
                            "- 不追了",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: ScreenUtil.getInstance().setSp(15)),
                          )
                              : Text(
                            "+ 追更新",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil.getInstance().setSp(15)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                  Material(
                    child: Ink(
                      child: InkWell(
                        onTap: () => {startRead()},
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                          decoration: BoxDecoration(
                            border: new Border.all(
                                color: GlobalColors.themeColor, width: 1),
                            // 边色与边宽度
                            borderRadius: new BorderRadius.circular((5.0)), // 圆角度
                          ),
                          child: Text(
                            "开始阅读",
                            style: TextStyle(
                                color: GlobalColors.themeColor,
                                fontSize: ScreenUtil.getInstance().setSp(15)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //以上是 追更新 开始阅读 -------------------------------------------------------------------------------------------------------------------------------------------------------
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(vertical: 3),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text(
                        '追书人数',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        bookDetailBean.latelyFollower.toString(),
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil.getInstance().L(50)),
                    child: Column(
                      children: <Widget>[
                        Text(
                          '读者留存率',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          bookDetailBean.retentionRatio.toString() + '%',
                          style: TextStyle(color: Colors.grey[600]),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        '更新字数/天',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        bookDetailBean.serializeWordCount.toString(),
                        style: TextStyle(color: Colors.grey[600]),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              indent: ScreenUtil.getInstance().L(20),
            ),
            buildChips(),
            buildLongInfo(),
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.symmetric(vertical: 3),
            ),
          ],
        ));
  }

  buildChips() {
    if (bookDetailBean.tags.isNotEmpty && bookDetailBean.tags.length > 0) {
      return Column(
        children: <Widget>[
          HotSugWidget(
            isVisible: false,
            hotWords: bookDetailBean.tags,
            goSearchList: goSearchList,
          ),
          Divider(
            indent: ScreenUtil.getInstance().L(20),
          )
        ],
      );
    } else {
      return Container();
    }
  }

  buildLongInfo() {
    return GestureDetector(
      onTap: () {
        setState(() {
          noShowCollapseLongIntro = !noShowCollapseLongIntro;
        });
      },
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                bookDetailBean.longIntro,
                maxLines: (noShowCollapseLongIntro ? 4 : 20),
                overflow: TextOverflow.ellipsis,
              )),
          Container(
              child: Icon(noShowCollapseLongIntro
                  ? Icons.keyboard_arrow_up
                  : Icons.keyboard_arrow_down))
        ],
      ),
    );
  }

  //追更新
  joinCollection() {
    if (isCollect) {
      setState(() {
        isCollect = false;
      });
      ToastUtils.info(context, "已取消追更");
      bookShelfDbProvider.delete(bookDetailBean.id);
      //删除于书架
      for (int i = 0; i < recommendBooksList.length; i++) {
        if (recommendBooksList[i].id == bookDetailBean.id) {
          recommendBooksList.removeAt(i);
          break;
        }
      }
    } else {
      setState(() {
        isCollect = true;
      });
      ToastUtils.info(context, "添加成功");
      //添加到书架
      RecommendBooks recommendBooks =
      RecommendBooks.fromJson(bookDetailBean.toJson());
      recommendBooksList.add(recommendBooks);
      bookShelfDbProvider.insert(recommendBooks.id, DateTime.now(),
          json.encode(recommendBooks.toJson()));
    }
  }

  //开始阅读
  startRead() {
    NavigatorUtils.gotoReadBookPage(
        context, bookDetailBean.title, bookDetailBean.id);
  }

  void goSearchList(String qery) {
    NavigatorUtils.gotoBookByTagsPage(context, qery, "Tags");
  }

  //全本缓存
  void cacheBook() async{
    AlertCupertinoUtil.showAletWithTitle(context,title: "是否全本缓存?",contentText: '虽然用不了几M...',onAllow: ()async{
      ToastUtils.info(context, "开始缓存");
      Data data = await dioGetAToc(bookDetailBean.id, "chapters");
      MixToc mixToc = data.data;
      List<Chapters> chaptersList = mixToc.chapters;
      Code.eventBus.fire(
          new DownloadEvent(bookDetailBean.id, chaptersList, 0, chaptersList.length - 1, DownloadEventType.start, current: 0));
    });

  }
}