import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zwt_life_flutter_app/common/manager/settingmanager.dart';
import 'package:zwt_life_flutter_app/public.dart';

//找书
class FindBookPage extends StatefulWidget {
  static final String sName = "FindBookPage";

  @override
  _FindBookPageState createState() {
    // TODO: implement createState
    return _FindBookPageState();
  }
}

class _FindBookPageState extends State<FindBookPage> {
  RefreshController _refreshController;
  ScrollController _scrollController;
  var tabList = [
  ['static/images/rankinglist.png', '排行榜'],
  ['static/images/sortlist.png', "分类",],
  ['static/images/booklist.png', "主题书单",]];

  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  @override
  void initState() {
    _refreshController = new RefreshController();
    _scrollController = new ScrollController();
    super.initState();
  }


  returnItem(int index) {
    return new Container(
      decoration: new BoxDecoration(
          border: new BorderDirectional(
              bottom:
              new BorderSide(color: Color(0xFFe1e1e1), width: 1.0))),
      child: Material(
        child: Ink(
          child: InkWell(
            onTap: () {
              tap(index);
            },
            child: new ListTile(
              leading: new ClipRRect(
                borderRadius: BorderRadius.circular(5.0),
                child: Image(
                  image: AssetImage(tabList[index][0]),
                  width: ScreenUtil.getInstance().L(25),
                  height: ScreenUtil.getInstance().L(25),
                  color: Colors.green[800],
                ),
              ),
              title: Text('${tabList[index][1]}'),
              trailing: Icon(
                Icons.keyboard_arrow_right, color: Colors.grey,),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: GlobalColors.appbarColor,
        middle: Text('找书'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Semantics(
            child: IconButton(
                onPressed: () => {},
                icon: Icon(CupertinoIcons.search, color: Colors.black)),
          ),
        ),
      ),
      child: DefaultTextStyle(
        style: CupertinoTheme
            .of(context)
            .textTheme
            .textStyle,
        child: Center(
          child: CupertinoScrollbar(
              child: SmartRefresher(
                  controller: _refreshController,
                  enablePullDown: false,
                  enablePullUp: false,
                  child: new ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemCount: tabList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return returnItem(index);
                      }))),
        ),
      ),
    );
  }


  //点击阅读
  void tap(int position) async {
    switch(position){
      //排行榜
      case 0:
        NavigatorUtils.gotoTopRankPage(context);
        break;
    }
  }
}