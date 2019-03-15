import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/model/Search.dart';
import 'package:zwt_life_flutter_app/common/net/services/search.dart';
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
  SearchResultListModal listData = SearchResultListModal([]);
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
      ),
      body: SearchResultListWidget(listData,
          getNextPage: () => getSearchList(widget.keyword)),
    );
  }

  getSearchList(String keyword) async {
    var data = await dioGetSearchResult(keyword, page++);
    SearchResultListModal listModal = SearchResultListModal.fromJson(data);
    setState(() {
      listData.data.addAll(listModal.data);
    });
  }
  @override
  void initState() {
    getSearchList(widget.keyword);
    super.initState();
  }
}
