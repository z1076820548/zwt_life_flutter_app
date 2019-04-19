import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zwt_life_flutter_app/common/manager/settingmanager.dart';
import 'package:zwt_life_flutter_app/public.dart';

//排行榜
class TopRankPage extends StatefulWidget {
  static final String sName = "TopRankPage";

  @override
  _TopRankPageState createState() {
    // TODO: implement createState
    return _TopRankPageState();
  }
}

class _TopRankPageState extends State<TopRankPage> with RouteAware{
  ScrollController _scrollController;

  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  @override
  void initState() {
    _scrollController = new ScrollController();
    Future.delayed(const Duration(microseconds: 0),()async{
      await initGetRank();
    });
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
//                  image: AssetImage(tabList[index][0]),
                  width: ScreenUtil.getInstance().L(25),
                  height: ScreenUtil.getInstance().L(25),
                  color: Colors.green[800],
                ),
              ),
//              title: Text('${tabList[index][1]}'),
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
        middle: Text('排行榜'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
        ),
      ),
      child: DefaultTextStyle(
        style: CupertinoTheme
            .of(context)
            .textTheme
            .textStyle,
        child: SafeArea(
          child: Center(
            child: CupertinoScrollbar(
                child: new ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return returnItem(index);
                    })),
          ),
        ),
      ),
    );
  }


  //点击阅读
  void tap(int position) async {
    switch(position){

    }
  }

  initGetRank() async{
    ResultData res = await dioGetTopBank();
    if(res.data != null){
      Map map  = res.data;

    }
  }
}