import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/net/services/search.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/NavigatorUtils.dart';
import 'package:zwt_life_flutter_app/common/widgets/searchwidget/hotSug.dart';
import 'package:zwt_life_flutter_app/common/widgets/searchwidget/recomend.dart';
import 'package:zwt_life_flutter_app/common/widgets/searchwidget/topbar.dart';

class SearchPage extends StatefulWidget {
  static final String sName = "Search";

  @override
  _SearchPageState createState() {
    // TODO: implement createState
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  List hotWords = [];
  List<String> recomendWords = [];
  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: GlobalColors.searchBarBgColor,
          leading: SearchTopBarLeadingWidget(),
          actions: <Widget>[
            SearchTopBarActionWidget(
              onActionTap: () => goSearchList(controller.text),
            )
          ],
          elevation: 0,
          titleSpacing: 0,
          title: SearchTopBarTitleWidget(
            searchTxtChanged: seachTxtChanged,
            controller: controller,
          )),
      body: recomendWords.length == 0
          ? HotSugWidget(
              hotWords: hotWords,
              goSearchList: goSearchList,
            )
          : RecomendListWidget(items: recomendWords, onItemTap: goSearchList),
    );
  }

  goSearchList(String keyWord) {
    if (keyWord.trim().isNotEmpty) {
      NavigatorUtils.goSearchResultListPage(context);
    }
  }

  onSearchBtTap() {
    if (controller.text.trim().isNotEmpty) {
      goSearchList(controller.text);
    }
  }

  void seachTxtChanged(String q) async {
    var result = await dioGetSuggest(q) as List;
    recomendWords = result.map((dynamic i) {
      List item = i as List;
      return item[0] as String;
    }).toList();
    setState(() {});
  }

  void initData() async {
    List querys = await dioGetHotSugs();
    setState(() {
      hotWords = querys;
    });
  }
}
