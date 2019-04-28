import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/net/services/search.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/NavigatorUtils.dart';
import 'package:zwt_life_flutter_app/common/widgets/searchwidget/history.dart';
import 'package:zwt_life_flutter_app/common/widgets/searchwidget/hotSug.dart';
import 'package:zwt_life_flutter_app/common/widgets/searchwidget/topbar.dart';
import 'package:zwt_life_flutter_app/page/searchpage/SuggestionList.dart';
import 'package:zwt_life_flutter_app/public.dart';

class SearchPage extends StatefulWidget {
  static final String sName = "SearchPage";

  @override
  _SearchPageState createState() {
    // TODO: implement createState
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  List<String> hotWords = [];
  List<String> listHot = [];
  List<String> listHistory = [
    "4564564",
    "566565",
    "454645645",
    "6554564654654",
    "4556545"
  ];
  List<String> recomendWords = [];
  TextEditingController controller = new TextEditingController();
  bool isShowSuggesList = false;
  List<String> suggestions;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
    controller.addListener(() async {
      if (controller.text.trim().isNotEmpty) {
        Data data = await dioGetAutoComplete(controller.text);
        setState(() {
          isShowSuggesList = true;
          suggestions = data.data;
        });
      } else {
        setState(() {
          isShowSuggesList = false;
        });
      }
    });
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
              textMessageSubmitted: seachTxtSubmitted,
              controller: controller,
            )),
        body: CupertinoScrollbar(
          child: isShowSuggesList
              ? SuggestionList(
                  suggestions: suggestions,
                  query: controller.text,
                  onSelected: goSearchList,
                )
              : buildView(),
        ));
  }

  goSearchList(String keyWord) {
    if (keyWord.trim().isNotEmpty) {
      NavigatorUtils.goSearchResultListPage(context, keyWord);
    }
  }

  onSearchBtTap() {
    if (controller.text.trim().isNotEmpty) {
      goSearchList(controller.text);
    }
  }

  void seachTxtSubmitted(String s) async {
    if (s.trim().isNotEmpty) {
      NavigatorUtils.goSearchResultListPage(context, s);
    }
  }

  void initData() async {
    Data data = await dioGetHotSugs();
    HotWordBean hotWordBean = data.data;
    setState(() {
      hotWords = hotWordBean.hotWords;
    });
    tapSwitch();
  }

  tapSwitch() {
    int tagSize = 10;
    List<String> list = [];
    for (int i = 0; i < tagSize; i++) {
      currentIndex++;
      if (currentIndex >= hotWords.length) {
        currentIndex = 0;
      }
      list.add(hotWords[currentIndex]);
    }
    setState(() {
      listHot = list;
    });
  }

  buildView() {
    return Column(
      children: <Widget>[
        (listHot == 0)
            ? Container()
            : HotSugWidget(
                hotWords: listHot,
                goSearchList: goSearchList,
                tapSwitch: () {
                  tapSwitch();
                },
              ),
        (listHistory == 0)
            ? Container()
            : HistoryListWidget(
                items: listHistory,
                onItemTap: goSearchList,
              ),
      ],
    );
  }
}
