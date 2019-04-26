import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:zwt_life_flutter_app/public.dart';

class TopCategoryPage extends StatefulWidget {
  static final String sName = "TopCategoryPage";

  @override
  _TopCategoryPageState createState() {
    // TODO: implement createState
    return _TopCategoryPageState();
  }
}

class _TopCategoryPageState extends State<TopCategoryPage> {
  CategoryList categoryList;
  List sliveTitle = ['男生', '女生', '出版', '漫画'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("分类"),
      ),
      body: CupertinoScrollbar(
        child: Container(
          child: _buildView(),
        ),
      ),
    );
  }

  void initData() async {
    Data res = await dioGetCategoryList();
    if (res.result) {
      setState(() {
        categoryList = res.data;
      });
    }
  }

  List<Widget> _buildSlivers(BuildContext context) {
    List<Widget> slivers = new List<Widget>();
    for (int i = 0; i < 3; i++) {
      slivers.add(_buildHeaderBuilderLists(context, i));
    }
    return slivers;
  }

  Widget _buildHeaderBuilderLists(BuildContext context, int count) {
    return SliverStickyHeaderBuilder(
      builder: (context, state) {
        return Container(
          child: ListTile(title: Text('${sliveTitle[count]}')),
          color: Colors.grey[100],
        );
      },
      sliver: _buildGridView(count),
    );
  }

  _buildGridView(int count) {
    List<Male> list;
    String type;
    switch (count) {
      case 0:
        list = categoryList.male;
        type = 'male';
        break;
      case 1:
        list = categoryList.female;
        type = 'female';
        break;
      case 2:
        list = categoryList.press;
        type = 'press';

        break;
      case 3:
        list = categoryList.picture;
        type = 'picture';
        break;
    }

    if (list.length == 0) {
      return Container();
    }
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, //每行三列
        childAspectRatio: 2,
      ),
      delegate: new SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return returnItem(list[index], type);
        },
        childCount: list.length,
      ),
    );
  }

  returnItem(Male item, String type) {
    return Material(
      child: Ink(
        child: InkWell(
          onTap: () {
            tap(item, type);
          },
          child: Container(
              decoration: BoxDecoration(
                border: new Border.all(color: Color(0xFFe1e1e1), width: 0.2),
              ),
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      item.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenUtil.getInstance().setSp(16)),
                    ),
                  ),
                  Container(
                    child: Text(
                      item.bookCount.toString() + "本",
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: ScreenUtil.getInstance().setSp(12)),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  _buildView() {
    if (categoryList != null) {
      return CustomScrollView(
        slivers: _buildSlivers(context),
      );
    } else {
      return Container();
    }
  }

  void tap(Male item, String type) {
    NavigatorUtils.gotoCategoryListDetailPage(context, item.name, type);
  }
}
