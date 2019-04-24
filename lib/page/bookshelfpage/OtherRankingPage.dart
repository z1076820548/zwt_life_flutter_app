import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:zwt_life_flutter_app/public.dart';
import 'package:extended_image/extended_image.dart';

//排行榜细节
class OtherRankingPage extends StatefulWidget {
  static final String sName = "RankingPage";
  final String bookId;
  final String title;

  const OtherRankingPage({Key key, this.bookId, this.title}) : super(key: key);



  @override
  _OtherRankingPageState createState() {
    // TODO: implement createState
    return _OtherRankingPageState();
  }
}

class _OtherRankingPageState extends State<OtherRankingPage> with RouteAware {
  List<BooksBean> booksWeek = [];

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
           title: Text(widget.title),
         ),
        body: CupertinoScrollbar(
          child:
              Center(
                child: _buildTabView(booksWeek),
              ),
        ),
    );
  }

  initGetRank() async {
    Data res = await dioGetRankingDetail(widget.bookId);
    if (res.data != null) {
      RankingBean rankingBean = res.data;
      List<BooksBean> books = rankingBean.books;
      setState(() {
        booksWeek = books;
      });
    }


  }

  _buildTabView(List<BooksBean> books) {
    return Container(
      padding: EdgeInsets.only(top: 0),
      child: ListView.builder(
          itemCount: books.length,
          itemBuilder: (BuildContext context, int index) {
            return returnItem(books[index]);
          }),
    );
  }

  void tap(BooksBean book) {
    NavigatorUtils.gotoBookDetailPage(context, book.id);
  }
}
