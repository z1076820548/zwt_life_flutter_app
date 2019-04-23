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
  List<BooksBean2> booksWeek = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 100), () async {
      await initGetRank();
    });
  }

  returnItem(BooksBean2 book) {
    return Material(
      child: Ink(
        child: InkWell(
          onTap: (){},
          child: Container(
            child: Row(
              children: <Widget>[
                Container(

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5.0),
                    child: ExtendedImage.network(
                      (Constant.IMG_BASE_URL + book.cover),
                      width: ScreenUtil.getInstance().L(50),
                      height: ScreenUtil.getInstance().L(50),
                      cache: true,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: new BoxDecoration(
                        border: new BorderDirectional(
                            bottom: new BorderSide(color: Color(0xFFe1e1e1), width: 0.5))),
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
                          book.author + ' | '+book.majorCate,
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
                              " 人在追 | " +
                              book.retentionRatio +
                              " %读者留存率",
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: ScreenUtil.getInstance().setSp(12)),
                        ),
                      ],
                    ),
                  ),
                )
//          Stack(
//            children: <Widget>[
//              Positioned(
//                child: Text(book.title),
//              ),
//              Text(book.author + ' | ' + book.majorCate),
//              Text(book.shortIntro),
//              Text(book.latelyFollower.toString() +
//                  " 人在追 | " +
//                  book.retentionRatio +
//                  " %读者留存率"),
//            ],
//          ),
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
        appBar: AppBar(
          title: Text(widget.title),
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
        body: CupertinoScrollbar(
          child: TabBarView(
            children: <Widget>[
              Center(
                child: _buildTabView(booksWeek),
              ),
              Center(
                child: Text('自信吃'),
              ),
              Center(
                child: Text('自信吃'),
              )
            ],
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
      List<BooksBean2> books2 = [];
      for (BooksBean bean in books) {
        BooksBean2 bean2 = BooksBean2.fromJson(bean.toJson());
        books2.add(bean2);
      }
      setState(() {
        booksWeek = books2;
      });
    }
  }

  _buildTabView(List<BooksBean2> books) {
    return ListView.builder(
        itemCount: books.length,
        itemBuilder: (BuildContext context, int index) {
          return returnItem(books[index]);
        });
  }
}
