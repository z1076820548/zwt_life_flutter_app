//Grid
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';

class SwipperGrid extends StatelessWidget {
  var tabImages = [
    [Icons.image, "照片"],
    [Icons.camera_alt, "拍摄 "],
    [Icons.phone, "语音通话"],
    [Icons.location_on, "位置"],
    [Icons.view_compact, "红包"],
    [Icons.record_voice_over, "语音输入"],
    [Icons.collections_bookmark, "收藏"],
    [Icons.person_outline, "个人名片"],
    [Icons.image, "文件"],
    [Icons.camera_alt, "卡券"]
  ];

  SwipperGrid({Key key}) : super(key: key);

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
            crossAxisCount: 4, //每行4个
            childAspectRatio: 1.0 //显示区域宽高相等
            ),
        itemCount: tabImages.length,
        itemBuilder: (context, indexItem) {
          if (indexItem > 7) {
            //7个一页
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