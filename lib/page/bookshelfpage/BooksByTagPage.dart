import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zwt_life_flutter_app/public.dart';
import 'package:extended_image/extended_image.dart';

//小说标签
class BooksByTagPage extends StatefulWidget {
  static final String sName = "BooksByTagPage";
  final String tag;

  const BooksByTagPage({Key key, this.tag}) : super(key: key);

  @override
  _BooksByTagPageState createState() {
    // TODO: implement createState
    return _BooksByTagPageState();
  }
}

class _BooksByTagPageState extends State<BooksByTagPage> {
  List<TagBookBean> tagList = [];
  RefreshController _refreshController = new RefreshController();
  int currentStart = 0;
  int currentLimit = 10;
  bool isLoadeMore = false;

  @override
  void initState() {
    super.initState();
    initData();
  }

  returnItem(TagBookBean book) {
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text(widget.tag),
      ),
      body: CupertinoScrollbar(
        child: Center(
          child: _buildTabView(),
        ),
      ),
    );
  }

  initData() async {
    Data res = await dioGetBookByTags(
        widget.tag, currentStart.toString(), currentLimit.toString());
    if (res.data != null) {
      List<TagBookBean> list = res.data;
      setState(() {
        tagList = list;
        currentStart = tagList.length;
        if (list.length >= currentLimit) {
          isLoadeMore = true;
        }
      });
    }
  }

  loadMore() async {
    Data res = await dioGetBookByTags(
        widget.tag, currentStart.toString(), currentLimit.toString());
    if (res.data != null) {
      List<TagBookBean> list = res.data;
      setState(() {
        tagList.addAll(list);
        currentStart = tagList.length;
        if (list.length > 0) {
          _refreshController.sendBack(false, RefreshStatus.completed);
          _refreshController.sendBack(false, RefreshStatus.idle);
        } else {
          _refreshController.sendBack(false, RefreshStatus.noMore);
        }
      });
    }
  }

  _buildTabView() {
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
            Future.delayed(Duration(milliseconds: 100), () async {
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

  void tap(TagBookBean book) {
    NavigatorUtils.gotoBookDetailPage(context, book.id);
  }
}
