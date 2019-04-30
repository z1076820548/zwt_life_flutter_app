import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/model/Search.dart';
import 'package:zwt_life_flutter_app/common/net/services/search.dart';
import 'package:zwt_life_flutter_app/public.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/widgets/searchwidget/listtopbar.dart';
import 'package:zwt_life_flutter_app/common/widgets/searchwidget/searchresult.dart';
import 'package:zwt_life_flutter_app/common/widgets/searchwidget/topbar.dart';

class SearchResultListPage extends StatefulWidget {
  final String keyword;

  const SearchResultListPage({Key key, this.keyword}) : super(key: key);

  @override
  SearchResultListState createState() {
    // TODO: implement createState
    return SearchResultListState();
  }
}

class SearchResultListState extends State<SearchResultListPage> {
  List<TagBookBean> listData = [];
  int page = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: GlobalColors.searchAppBarBgColor,
          leading: SearchTopBarLeadingWidget(),
          elevation: 0,
          titleSpacing: 0,
          title: SearchListTopBarTitleWidget(keyworld: widget.keyword),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: SearchTopBarActionWidget(
                onActionTap: () => Navigator.pop(context),
                text: "取消",
              ),
            )
          ],
        ),
        body: Container(
            child: CupertinoScrollbar(
          child: (listData == null || listData.length == 0)
              ? Container()
              : SearchResultListWidget(listData, onItemTap: (String id) {
                  NavigatorUtils.gotoBookDetailPage(context, id);
                }),
        )));
  }

  getSearchList(String keyword) async {
    Data data = await dioGetSearchBooksByAuthor(keyword);
    List<TagBookBean> listAutor = data.data;
    Data data2 = await dioGetSearchBooks(keyword);
    List<TagBookBean> listBooks = data2.data;
    listData.clear();
    listData.addAll(listAutor);
    listData.addAll(listBooks);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getSearchList(widget.keyword);
  }
}
