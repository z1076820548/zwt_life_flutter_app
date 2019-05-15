import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zwt_life_flutter_app/common/net/Code.dart';
import 'package:zwt_life_flutter_app/common/widgets/bookshelfwidget/CategoryListDetailWidget.dart';
import 'package:zwt_life_flutter_app/public.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

//小说二级分类
class CategoryListDetailPage extends StatefulWidget {
  static final String sName = "CategoryListDetailPage";
  final String cate;

  final String gender;

  const CategoryListDetailPage({Key key, this.cate, this.gender})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CategoryListDetailPageState();
  }
}

class CategoryListDetailPageState extends State<CategoryListDetailPage>
    with SingleTickerProviderStateMixin {
  List<String> mMinors = [];
  List<bool> check = [];
  List<BooksBean> ListHot = [], ListNew = [], ListRe = [], ListOver = [];
  String HOT = "hot";
  String NEW = "new";
  String REPUTATION = "reputation";
  String OVER = "over";
  static String currentMinors = '';
  double opacityValue = 0.2;
  double _top = 0.0;
  double _left = 0.0;
  double _bottom = 0.0;
  double _right = 0.0;

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[

          Positioned(
            child: DefaultTabController(
              length: 4,
              child: Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  elevation: 0,
                  title: Text(widget.cate),
                  bottom: TabBar(
                    tabs: <Widget>[
                      Tab(
                        text: '热门',
                      ),
                      Tab(
                        text: '新书',
                      ),
                      Tab(
                        text: '好评',
                      ),
                      Tab(
                        text: '完结',
                      )
                    ],
                  ),
                ),
                body: CupertinoScrollbar(
                  child: TabBarView(
                    children: <Widget>[
                      CategoryListDetailWidget(
                          list: ListHot,
                          gender: widget.gender,
                          major: widget.cate,
                          minor: currentMinors,
                          type: HOT),
                      CategoryListDetailWidget(
                          list: ListNew,
                          gender: widget.gender,
                          major: widget.cate,
                          minor: currentMinors,
                          type: NEW),
                      CategoryListDetailWidget(
                          list: ListRe,
                          gender: widget.gender,
                          major: widget.cate,
                          minor: currentMinors,
                          type: REPUTATION),
                      CategoryListDetailWidget(
                          list: ListOver,
                          gender: widget.gender,
                          major: widget.cate,
                          minor: currentMinors,
                          type: OVER),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: _top,
            left: _left,
            bottom: _bottom,
            right: _right,
            child: Opacity(
              opacity: opacityValue,
              child: GestureDetector(
                //手指按下时会触发此回调
                onPanDown: (DragDownDetails e) {
                  //打印手指按下的位置(相对于屏幕)
                  print("用户手指按下：${e.globalPosition}");
                },
                onPanUpdate: (DragUpdateDetails e) {
                  //用户手指滑动时，更新偏移，重新构建
                  setState(() {
                    print("偏移：${e.globalPosition}");
                    _left += e.delta.dx;
                    _right -= e.delta.dx;
                    _top += e.delta.dy;
                    _bottom -= e.delta.dy;
                  });
                },
                child: SpeedDial(
                  marginRight: 18,
                  marginBottom: 20,
                  animatedIcon: AnimatedIcons.menu_close,
                  animatedIconTheme: IconThemeData(size: 22.0),
                  curve: Curves.bounceIn,
//                      overlayColor: Colors.black,
                  overlayOpacity: 0.1,
                  onOpen: () {
                    setState(() {
                      opacityValue = 1;
                    });
                  },
                  onClose: () {
                    setState(() {
                      opacityValue = 0.2;
                    });
                  },
                  tooltip: '分类',
                  heroTag: '分类',
                  backgroundColor: GlobalColors.themeColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: CircleBorder(),
                  children: children(),
                ),
              ),
            ),
          ),
        ],

      ),
    );
  }

  List<SpeedDialChild> children() {
    List<SpeedDialChild> children = new List();
    for (int i = 0; i < mMinors.length; i++) {
      children.add(SpeedDialChild(
          child: check[i] ? Icon(Icons.check) : Icon(Icons.clear),
          backgroundColor: check[i] ? GlobalColors.themeColor : Colors.red,
          label: mMinors[i],
          onTap: () {
            setState(() {
              if (mMinors[i] == widget.cate) {
                currentMinors == "";
              } else {
                currentMinors = mMinors[i];
              }
              Code.eventBus.fire(new CategoryEvent(currentMinors));
              if (!check[i]) {
                for (int j = 0; j < check.length; j++) {
                  if (j == i) {
                    check[j] = !check[j];
                  } else {
                    check[j] = false;
                  }
                }
              }

//              ToastUtils.info(context, "当前类别:" + mMinors[i]);
            });
          }));
    }
    return children;
  }

  initData() async {
    //获取二级分类
    Data res = await dioGetCategoryList2();
    if (res.data != null) {
      CategoryList2 data = res.data;
      mMinors.clear();
      check.clear();
      mMinors.add(widget.cate);
      check.add(true);
      switch (widget.gender) {
        case "male":
          for (CategoryList2DataBean bean in data.male) {
            if (widget.cate == bean.major) {
              for (int i = 0; i < bean.mins.length; i++) {
                mMinors.add(bean.mins[i]);
                check.add(false);
              }
              break;
            }
          }
          break;
        case "female":
          for (CategoryList2DataBean bean in data.female) {
            if (widget.cate == bean.major) {
              for (int i = 0; i < bean.mins.length; i++) {
                mMinors.add(bean.mins[i]);
                check.add(false);
              }
              break;
            }
          }
          break;
        case 'picture':
          for (CategoryList2DataBean bean in data.picture) {
            if (widget.cate == bean.major) {
              for (int i = 0; i < bean.mins.length; i++) {
                mMinors.add(bean.mins[i]);
                check.add(false);
              }
              break;
            }
          }
          break;
        case 'press':
          for (CategoryList2DataBean bean in data.press) {
            if (widget.cate == bean.major) {
              for (int i = 0; i < bean.mins.length; i++) {
                mMinors.add(bean.mins[i]);
                check.add(false);
              }
              break;
            }
          }
          break;
      }
    }
    setState(() {});
  }
}
