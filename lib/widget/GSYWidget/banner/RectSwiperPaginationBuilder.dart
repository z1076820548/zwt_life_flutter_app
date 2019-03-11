import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:zwt_life_flutter_app/common/model/kingkong.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';

class RectSwiperPaginationBuilder extends SwiperPlugin {
  ///color when current index,if set null , will be Theme.of(context).primaryColor
  final Color activeColor;

  ///,if set null , will be Theme.of(context).scaffoldBackgroundColor
  final Color color;

  ///Size of the rect when activate
  final Size activeSize;

  ///Size of the rect
  final Size size;

  /// Space between rects
  final double space;

  final Key key;

  const RectSwiperPaginationBuilder(
      {this.activeColor,
      this.color,
      this.key,
      this.size: const Size(10.0, 2.0),
      this.activeSize: const Size(10.0, 2.0),
      this.space: 3.0});

  @override
  Widget build(BuildContext context, SwiperPluginConfig config) {
    List<Widget> list = [];
    int itemCount = config.itemCount;
    int activeIndex = config.activeIndex;

    for (int i = 0; i < itemCount; i++) {
      bool active = i == activeIndex;
      Size size = active ? this.activeSize : this.size;
      list.add(Container(
        width: size.width,
        height: size.height,
        color: active ? activeColor : color,
        key: Key("pagination_$i"),
        margin: EdgeInsets.all(space),
      ));
    }

    // TODO: implement build
    return Row(
      key: key,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: list,
    );
  }
}

//轮播图
class SwipperBanner extends StatelessWidget {
  final List<String> banners;

  SwipperBanner({this.banners});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = ScreenUtil().L(115);
    // TODO: implement build
    return Container(
      width: width,
      height: height,
      child: Swiper(
        itemBuilder: (BuildContext context, index) {
          return Container(
              width: width,
              height: height,
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  image: NetworkImage(banners[index]),
                ),
              ));
        },
        itemCount: banners.length,
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: RectSwiperPaginationBuilder(
              color: Colors.grey[350],
              activeColor: Colors.white,
              size: Size(5.0, 2),
              activeSize: Size(5, 5)),
        ),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) => print('点击了第$index个'),
      ),
    );
  }
}

//Grid
class SwipperGrid extends StatelessWidget {
  final KingKongList data;

  SwipperGrid({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = ScreenUtil().L(140);
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(8),
      width: width,
      height: height,
      child: Swiper(
        itemBuilder: (BuildContext context, indexPage) {
          return _gridView(indexPage);
        },
        itemCount: 2,
        pagination: SwiperPagination(
          margin: EdgeInsets.only(top: 50),
          alignment: Alignment.bottomCenter,
          builder: RectSwiperPaginationBuilder(
              color: Colors.grey[350],
              activeColor: Theme.of(context).primaryColor,
              size: Size(5.0, 2),
              activeSize: Size(5, 5)),
        ),
        scrollDirection: Axis.horizontal,
        autoplay: false,
//        onTap: (index) => print('点击了第$index个'),
      ),
    );
  }

  Widget _gridView(int indexPage) {
    return GridView.builder(
        physics: NeverScrollableScrollPhysics(), //禁用滚动 解决滑动冲突
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5, //每行五个
            childAspectRatio: 1.0 //显示区域宽高相等
            ),
        itemCount: data.items.length,
        itemBuilder: (context, indexItem) {
          if (indexItem > 9) {
            //10个一页
            return null;
          }
          //如果显示到最后一个并且Icon总数小于200时继续获取数据
          return _KingKongItemWidget(
              item: data.items[indexItem],
              indexPage: indexPage,
              indexItem: indexItem);
        });
  }
}

class _KingKongItemWidget extends StatelessWidget {
  final KingKongItem item;
  final int indexPage, indexItem;

  _KingKongItemWidget({Key key, this.item, this.indexPage, this.indexItem})
      : super(key: key);

  _tap(indexPage, indexItem) {
    print('点击了第$indexPage页$indexItem个Item');
  }

  @override
  Widget build(BuildContext context) {
    return Listener(//监听原始指针事件 防止手势冲突
      onPointerDown: (details) {
        _tap(indexPage, indexItem);
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: Image.network(
                item.picUrl,
                width: ScreenUtil().L(40),
                height: ScreenUtil().L(35),
              ),
            ),
            Padding(padding: new EdgeInsets.all(3)),
            Text(
              item.title,
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
