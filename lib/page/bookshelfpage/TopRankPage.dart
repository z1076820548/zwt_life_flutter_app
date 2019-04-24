import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:zwt_life_flutter_app/public.dart';
import 'package:extended_image/extended_image.dart';

//小说排行榜
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
  List<MaleBean> maleGroups = [];
  List<List<MaleBean>> maleChilds = [];

  List<MaleBean> femaleGroups = [];
  List<List<MaleBean>> femaleChildes = [];
  List sliveTitle = ['男生', '女生'];

  @override
  void initState() {
    super.initState();

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
          child: Icon(
            Icons.more,
            color: Colors.orange,
            size: ScreenUtil.getInstance().L(25),
          ),
        ),
        title: Text(myGroups[index].title),
        children: returnExpandItem(myChilds[0], index),
      );
    } else {
      return Container(
        decoration: new BoxDecoration(
            border: new BorderDirectional(
                bottom: new BorderSide(color: Color(0xFFe1e1e1), width: 0.5))),
        child: ListTile(
          onTap: () {
            tap(myGroups[index]);
          },
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: ExtendedImage.network(
              (Constant.IMG_BASE_URL + myGroups[index].cover),
              height: ScreenUtil.getInstance().L(25),
              fit: BoxFit.fitHeight,
              cache: true,
            ),
          ),
          title: Text('${myGroups[index].title}'),
        ),
      );
    }
  }

  List<Widget> returnExpandItem(List<MaleBean> myGroups, int index) {
    List<Widget> childs = new List();
    for (MaleBean bean in myGroups) {
      childs.add(Material(
        child: Ink(
          child: InkWell(
            onTap: () {
              tap2(bean);
            },
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 40),
                  ),
                  Text(bean.title)
                ],
              ),
            ),
          ),
        ),
      ));
    }
    return childs;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('排行榜'),
      ),
      body: CupertinoScrollbar(
        child: CustomScrollView(
          slivers: _buildSlivers(context),
        ),
      ),
    );
  }

  List<Widget> _buildSlivers(BuildContext context) {
    List<Widget> slivers = new List<Widget>();

    for (int i = 0; i < 2; i++) {
      slivers.add(_buildHeaderBuilderLists(context, i));
    }

    return slivers;
  }

  Widget _buildHeaderBuilderLists(BuildContext context, int count) {
    var groups, childs;
    if (count == 0) {
      groups = maleGroups;
      childs = maleChilds;
    } else if (count == 1) {
      groups = femaleGroups;
      childs = femaleChildes;
    }

    return SliverStickyHeaderBuilder(
      builder: (context, state) {
        return Container(
          child: ListTile(title: Text('${sliveTitle[count]}')),
          color: Colors.grey[100],
        );
      },
      sliver: new SliverList(
        delegate:
            new SliverChildBuilderDelegate((BuildContext context, int index) {
          return returnItem(groups, childs, index);
        }, childCount: groups.length),
      ),
    );
  }

  //点击阅读
  void tap(MaleBean maleBean) async {
    NavigatorUtils.gotoRankingPage(context, maleBean.id, maleBean.monthRank,
        maleBean.totalRank, maleBean.title);
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

  void tap2(MaleBean bean) {
    NavigatorUtils.gotoOtherRankingPage(context,bean.id,bean.title);
  }
}
