import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:zwt_life_flutter_app/public.dart';
import 'package:extended_image/extended_image.dart';

//排行榜细节
class RankingPage extends StatefulWidget {
  static final String sName = "RankingPage";
  final String week;
  final String month;
  final String all;
  final String title;

  const RankingPage({Key key, this.week, this.month, this.all, this.title})
      : super(key: key);

  @override
  _RankingPageState createState() {
    // TODO: implement createState
    return _RankingPageState();
  }
}

class _RankingPageState extends State<RankingPage> with RouteAware {
  List<BooksBean> booksWeek = [];
  List<BooksBean> booksMonth = [];
  List<BooksBean> booksAll = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () async {
      await initGetRank();
    });
  }

  returnItem(BooksBean book) {
    return Material(
      child: Ink(
        child: InkWell(
          onTap: () {},
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverAppBar(
                  title: Text(widget.title),
                  pinned: true,
                  expandedHeight: 150.0,
                  forceElevated: innerBoxIsScrolled,
                  bottom: TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: '周榜',
                      ),
                      Tab(
                        text: '月榜',
                      ),
                      Tab(
                        text: '总榜',
                      )
                    ],
                  ),
                ),
              ),
            ];
          },
          body: CupertinoScrollbar(
            child: TabBarView(
              children: <Widget>[
                Center(
                  child: _buildTabView(booksWeek),
                ),
                Center(
                  child: _buildTabView(booksMonth),
                ),
                Center(
                  child: _buildTabView(booksAll),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  initGetRank() async {
    Data res = await dioGetRankingDetail(widget.week);
    if (res.data != null) {
      RankingBean rankingBean = res.data;
      List<BooksBean> books = rankingBean.books;
      setState(() {
        booksWeek = books;
      });
    }

    Data res2 = await dioGetRankingDetail(widget.month);
    if (res2.data != null) {
      RankingBean rankingBean = res2.data;
      List<BooksBean> books = rankingBean.books;
      setState(() {
        booksMonth = books;
      });
    }

    Data res3 = await dioGetRankingDetail(widget.all);
    if (res3.data != null) {
      RankingBean rankingBean = res3.data;
      List<BooksBean> books = rankingBean.books;
      setState(() {
        booksAll = books;
      });
    }
  }

  _buildTabView(List<BooksBean> books) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (BuildContext context, int index) {
            return returnItem(books[index]);
          }),
    );
  }
}
