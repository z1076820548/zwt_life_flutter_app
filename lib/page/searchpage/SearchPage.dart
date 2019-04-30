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
  List<String> listHistory = [];
  List<String> recomendWords = [];
  TextEditingController controller = new TextEditingController();
  bool isShowSuggesList = false;
  List<String> suggestions;
  int currentIndex = 0;
  FocusNode focusNode = new FocusNode();
  final String HISTORY_KEY = 'history_key';
  ScrollController scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
    scrollController.addListener(() {
      if (scrollController.offset.abs() > 1) {
        focusNode.unfocus();
      }
    });
  }

  getHistory() {
    String s = sp.getString(HISTORY_KEY, "");
    if (s.isNotEmpty) {
      SearchHistory searchHistory = SearchHistory.fromJsonMap(jsonDecode(s));
      setState(() {
        listHistory = searchHistory.history;
      });
    }
  }

  deleteHistory() {
    FocusNode().unfocus();
    AlertCupertinoUtil.showAletWithTitle(context,
        contentText: '是否清空搜索历史?',
        allowText: "删除",
        cancleText: '取消',
        isDestructiveAction: true, onAllow: () {
      setState(() {
        listHistory.clear();
      });
      sp.putString(HISTORY_KEY, "");
    });
  }

  saveHistory(String s) {
    setState(() {
      listHistory.insert(0, s);
    });
    sp.putString(HISTORY_KEY, jsonEncode(SearchHistory(listHistory).toJson()));
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
                text: "搜索",
              )
            ],
            elevation: 0,
            titleSpacing: 0,
            title: SearchTopBarTitleWidget(
              textMessageSubmitted: seachTxtSubmitted,
              controller: controller,
              listener: listener,
              focusNode: focusNode,
            )),
        body: CupertinoScrollbar(
          child: Container(
            child: isShowSuggesList
                ? SuggestionList(
                    suggestions: suggestions,
                    query: controller.text,
                    onSelected: goSearchList,
                  )
                : buildView(),
          ),
        ));
  }

  goSearchList(String keyWord) {
    if (keyWord.trim().isNotEmpty) {
      NavigatorUtils.goSearchResultListPage(context, keyWord);
      focusNode.unfocus();
      saveHistory(keyWord);
      controller.clear();
      setState(() {
        isShowSuggesList = false;
        suggestions.clear();
      });
    }
  }

  listener(String s) async {
    if (s.trim().isNotEmpty) {
      Data data = await dioGetAutoComplete(controller.text);
      setState(() {
        isShowSuggesList = true;
        suggestions = data.data;
      });
    } else {
      setState(() {
        suggestions.clear();
        isShowSuggesList = false;
      });
    }
  }

  onSearchBtTap() {
    if (controller.text.trim().isNotEmpty) {
      goSearchList(controller.text);
      saveHistory(controller.text);
    }
  }

  void seachTxtSubmitted(String s) async {
    goSearchList(s);
    saveHistory(s);
  }

  void initData() async {
    Data data = await dioGetHotSugs();
    HotWordBean hotWordBean = data.data;
    setState(() {
      hotWords = hotWordBean.hotWords;
    });
    tapSwitch();
    getHistory();
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
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
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
                  items: ((listHistory.length <= 8)
                      ? listHistory
                      : listHistory.getRange(0, 8).toList()),
                  onItemTap: goSearchList,
                  tapDelete: () {
                    deleteHistory();
                  },
                ),
        ],
      ),
    );
  }
}
