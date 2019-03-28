//Grid
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwt_life_flutter_app/common/event/ChatImageEvent.dart';
import 'package:zwt_life_flutter_app/common/model/ChatSwipperGridModel.dart';
import 'package:zwt_life_flutter_app/common/net/Code.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/NavigatorUtils.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';

class ChatSwipperGrid extends StatelessWidget {
  List<ChatSwipperGridModel> tabImages = [
    ChatSwipperGridModel(Icons.image, "照片"),
    ChatSwipperGridModel(Icons.camera_alt, "拍摄"),
    ChatSwipperGridModel(Icons.phone, "语音通话"),
    ChatSwipperGridModel(Icons.location_on, "位置"),
    ChatSwipperGridModel(Icons.view_compact, "红包"),
    ChatSwipperGridModel(Icons.record_voice_over, "语音输入"),
    ChatSwipperGridModel(Icons.collections_bookmark, "收藏"),
    ChatSwipperGridModel(Icons.person_outline, "个人名片"),
    ChatSwipperGridModel(Icons.image, "文件"),
    ChatSwipperGridModel(Icons.camera_alt, "卡券"),
  ];

  ChatSwipperGrid({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = ScreenUtil().L(180);
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
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            color: Colors.black38,
            activeColor: GlobalColors.ChatTextColor,
            size: 5,
            activeSize: 6,
          ),
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
          if (indexPage == 0) {
            if (indexItem > 7) {
              //7个一页
              return null;
            }
            return _ItemWidget(
                item: tabImages[indexItem],
                indexPage: indexPage,
                indexItem: indexItem);
          } else if (indexPage == 1) {
            if (indexItem > 1) {
              return null;
            }
            return _ItemWidget(
                item: tabImages[indexItem + 8],
                indexPage: indexPage,
                indexItem: indexItem + 8);
          }

          //如果显示到最后一个并且Icon总数小于200时继续获取数据
        });
  }
}

class _ItemWidget extends StatelessWidget {
  final ChatSwipperGridModel item;
  final int indexPage, indexItem;

  _ItemWidget({Key key, this.item, this.indexPage, this.indexItem})
      : super(key: key);

  _tap(BuildContext context,indexPage, indexItem) {
    print('点击了第$indexPage页$indexItem个Item');
    switch (indexItem) {
      case 0:
        //照片
        getImage();
        break;
      case 1:
      //拍摄
        getCamera(context);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      //监听原始指针事件 防止手势冲突
      onPointerDown: (details) {
        _tap(context,indexPage, indexItem);
      },
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: Icon(
                item.iconData,
                size: ScreenUtil().L(40),
              ),
            ),
            Padding(padding: new EdgeInsets.all(3)),
            Text(
              item.title,
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  //获得图片文件
  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    Code.eventBus.fire(new ChatImageEvent(image: (image.path + "FILEIMAGE")));
  }

  void getCamera(BuildContext context) {
    NavigatorUtils.gotoChatCameraHomePage( context);
  }
}
