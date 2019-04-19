import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/public.dart';
import 'package:cached_network_image/cached_network_image.dart';

//排行榜
class TopRankPage extends StatefulWidget {
  static final String sName = "TopRankPage";

  @override
  _TopRankPageState createState() {
    // TODO: implement createState
    return _TopRankPageState();
  }
}

class _TopRankPageState extends State<TopRankPage> with RouteAware {
  ScrollController _scrollController;
  List<MaleBean> maleList = [];
  List<MaleBean> femaleList = [];
  List<List<MaleBean>> maleChilds = [];

  Image getTabImage(path) {
    return new Image.asset(path, width: 20.0, height: 20.0);
  }

  @override
  void initState() {
    super.initState();

    _scrollController = new ScrollController();
    Future.delayed(const Duration(milliseconds: 100), () async {
      await initGetRank();
    });
  }

  returnItem(List<MaleBean> mylist, int index) {
    return new ListTile(
      onTap: () {},
      leading: new ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: CachedNetworkImage(
          imageUrl: (Constant.IMG_BASE_URL + mylist[index].cover),
          width: ScreenUtil.getInstance().L(25),
          height: ScreenUtil.getInstance().L(25),
          placeholder: (context, url) => new CircularProgressIndicator(),
          errorWidget: (context, url, error) => new Icon(Icons.error),
        ),
      ),
      title: Text('${mylist[index].title}'),
      trailing: Icon(
        Icons.keyboard_arrow_right,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('排行榜'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: ListTile(title: Text('男生')),
              color: Colors.grey[200],
            ),
            Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: maleList.length,
                  itemExtent: 50,
                  itemBuilder: (BuildContext context, int index) {
                    return returnItem(maleList, index);
                  }),
            ),
          ],
        ));
//        Center(
//          child: Container(
//            child: Column(
//                children: <Widget>[
//              Container(
//                color: Colors.grey[200],
//                padding: EdgeInsets.all(10),
//                child: Row(
//                  children: <Widget>[Text('男生')],
//                ),
//              ),
//
//            ]),
//          ),
//        ));
  }

  //点击阅读
  void tap(int position) async {
    switch (position) {
    }
  }

  initGetRank() async {
    Data res = await dioGetTopBank();
    if (res.data != null) {
      Map map = res.data;
      List<MaleBean> isCollapseMale = [];
      List<MaleBean> noCollapseMale = [];
      List<MaleBean> male = (map['male'] as List)
          ?.map((e) =>
              e == null ? null : MaleBean.fromJson(e as Map<String, dynamic>))
          ?.toList();
      for (MaleBean maleBean in male) {
        if (maleBean.collapse) {
          isCollapseMale.add(maleBean);
        } else {
          noCollapseMale.add(maleBean);
        }
      }
      if(isCollapseMale.length > 0){
        noCollapseMale.add(new MaleBean(id, title, cover, collapse, monthRank, totalRank))
      }

      List<MaleBean> female = (map['female'] as List)
          ?.map((e) =>
              e == null ? null : MaleBean.fromJson(e as Map<String, dynamic>))
          ?.toList();
    }
  }
}
