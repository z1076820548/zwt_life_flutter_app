import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/public.dart';
import 'package:extended_image/extended_image.dart';

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
  String othertitle = '别人家的排行榜';
  ScrollController _scrollController;
  List<MaleBean> maleGroups = [];
  List<List<MaleBean>> maleChilds = [];

  List<MaleBean> femaleGroups = [];
  List<List<MaleBean>> femaleChildes = [];

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

  returnItem(
      List<MaleBean> myGroups, List<List<MaleBean>> myChilds, int index) {
    //别人家的排行榜
    if (myGroups[index].title.contains(othertitle)) {
      return ExpansionTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: Icon(Icons.more, color: Colors.orange),
        ),
        title: Text(myGroups[index].title),
        children: returnExpandItem(myChilds[0], index),
      );
    } else {
      return ListTile(
        onTap: () {},
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: ExtendedImage.network(
            (Constant.IMG_BASE_URL + myGroups[index].cover),
            width: ScreenUtil.getInstance().L(25),
            height: ScreenUtil.getInstance().L(25),
            cache: true,
          ),
        ),
        title: Text('${myGroups[index].title}'),
      );
    }
  }

  List<Widget> returnExpandItem(List<MaleBean> myGroups, int index) {
    List<Widget> childs = new List();
    for (MaleBean bean in myGroups) {
      childs.add(ListTile(
          onTap: () {},
          title: Text('${bean.title}'),
          leading: Container(
            width: 20,
          )));
    }
    return childs;
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
                itemCount: maleGroups.length,
                itemBuilder: (BuildContext context, int index) {
                  return returnItem(maleGroups, maleChilds, index);
                }),
          ),
          Container(
            child: ListTile(title: Text('女生')),
            color: Colors.grey[200],
          ),
          Expanded(
            child: ListView.builder(
                itemCount: maleGroups.length,
                itemBuilder: (BuildContext context, int index) {
                  return returnItem(femaleGroups, femaleChildes, index);
                }),
          ),
        ],
      ),
    );
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
      if (isCollapseMale.length > 0) {
        noCollapseMale.add(new MaleBean("", othertitle, "", false, "", ""));
      }

      List<MaleBean> isCollapseFemale = [];
      List<MaleBean> noCollapseFemale = [];
      List<MaleBean> female = (map['female'] as List)
          ?.map((e) =>
              e == null ? null : MaleBean.fromJson(e as Map<String, dynamic>))
          ?.toList();
      for (MaleBean maleBean in female) {
        if (maleBean.collapse) {
          isCollapseFemale.add(maleBean);
        } else {
          noCollapseFemale.add(maleBean);
        }
      }
      if (isCollapseMale.length > 0) {
        noCollapseFemale.add(new MaleBean("", othertitle, "", false, "", ""));
      }
      setState(() {
        maleGroups = noCollapseMale;
        maleChilds.add(isCollapseMale);

        femaleGroups = noCollapseFemale;
        femaleChildes.add(isCollapseFemale);
      });
    }
  }
}
