import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/event/CategoryEvent.dart';
import 'package:zwt_life_flutter_app/common/net/Code.dart';
import 'package:zwt_life_flutter_app/page/bookshelfpage/CategoryListDetailPage.dart';
import 'package:zwt_life_flutter_app/public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:extended_image/extended_image.dart';

class CategoryListDetailWidget extends StatefulWidget {
  static final String sName = "CategoryListDetailWidget";
  final String gender;
  final String major;
  final String minor;
  final String type;
  final List<BooksBean> list;

  const CategoryListDetailWidget(
      {Key key, this.gender, this.major, this.minor, this.type, this.list})
      : super(key: key);

  @override
  _CategoryListDetailWidgetState createState() {
    // TODO: implement createState
    return _CategoryListDetailWidgetState(list);
  }
}

class _CategoryListDetailWidgetState extends State<CategoryListDetailWidget> {
  RefreshController _refreshController = new RefreshController();
  int currentStart = 0;
  int currentLimit = 20;
  bool isLoadeMore = false;
  final List<BooksBean> booksBeanList;
  StreamSubscription _stream;
  static String currentMinors = CategoryListDetailPageState.currentMinors;

  _CategoryListDetailWidgetState(this.booksBeanList);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentMinors = CategoryListDetailPageState.currentMinors;
    _stream = Code.eventBus.on<CategoryEvent>().listen((event) {
      currentStart = 0;
      booksBeanList.clear();
      currentMinors = event.mMinors;
      initData();
    });

    initData();
  }

  @override
  void dispose() {
    _stream.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildTabView(widget.list);
  }

  _buildTabView(List<BooksBean> tagList) {
    if (tagList.length == 0) {
      return Container();
    }
    return Container(
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: false,
        enablePullUp: isLoadeMore,
        footerBuilder: CommonUtils.footerCreate,
        onRefresh: (up) {
          if (up) {
          } else {
            Future.delayed(Duration(milliseconds: 0), () async {
              await loadMore();
            });
          }
        },
        child: ListView.builder(
            itemCount: tagList.length,
            itemBuilder: (BuildContext context, int index) {
              return returnItem(tagList[index]);
            }),
      ),
    );
  }

  returnItem(BooksBean book) {
    return Material(
      child: Ink(
        child: InkWell(
          onTap: () {
            tap(book);
          },
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: ExtendedImage.network(
                    (Constant.IMG_BASE_URL + book.cover),
                    height: ScreenUtil.getInstance().L(50),
                    fit: BoxFit.fitHeight,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    cache: true,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: new BoxDecoration(
                        border: new BorderDirectional(
                            bottom: new BorderSide(
                                color: Color(0xFFe1e1e1), width: 0.5))),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            book.title,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil.getInstance().setSp(16)),
                          ),
                        ),
                        Text(
                          book.author + '  |  ' + book.majorCate,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenUtil.getInstance().setSp(12)),
                        ),
                        Text(
                          book.shortIntro,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenUtil.getInstance().setSp(12)),
                        ),
                        Text(
                          book.latelyFollower.toString() +
                              " 人在追  |  " +
                              book.retentionRatio.toString() +
                              "% 读者留存率",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: ScreenUtil.getInstance().setSp(12)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void tap(BooksBean book) {
    NavigatorUtils.gotoBookDetailPage(context, book.id);
  }

  loadMore() async {
    Data res = await dioGetBooksByCats(
        gender: widget.gender,
        major: widget.major,
        minor: widget.minor,
        type: widget.type,
        start: currentStart,
        limit: currentLimit);
    if (res.data != null) {
      List<BooksBean> list = res.data;
      setState(() {
        booksBeanList.addAll(list);
        currentStart = booksBeanList.length;
        if (list.length >= currentLimit) {
        } else {
          isLoadeMore = false;
        }
        if (list.length > 0) {
          _refreshController.sendBack(false, RefreshStatus.completed);
          _refreshController.sendBack(false, RefreshStatus.idle);
        } else {
          _refreshController.sendBack(false, RefreshStatus.noMore);
        }
      });
    }
  }

  void initData() async {
    Data res2 = await dioGetBooksByCats(
        gender: widget.gender,
        major: widget.major,
        minor: currentMinors,
        type: widget.type,
        start: currentStart,
        limit: currentLimit);
    List<BooksBean> list = res2.data;
    booksBeanList.clear();
    booksBeanList.addAll(list);
    currentStart = booksBeanList.length;
    if (list.length >= currentLimit) {
      isLoadeMore = true;
    } else {
      isLoadeMore = false;
    }
    setState(() {});
  }
}
