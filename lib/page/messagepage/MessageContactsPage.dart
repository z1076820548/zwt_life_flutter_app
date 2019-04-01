import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:zwt_life_flutter_app/public.dart';
class MessageContactsPage extends StatefulWidget {
  static final String sName = "MessageContacts";

  @override
  _MessageContactsPageState createState() {
    // TODO: implement createState
    return _MessageContactsPageState();
  }
}

final SlidableController slidableController = new SlidableController();
GlobalKey<EasyRefreshState> _easyRefreshKey = new GlobalKey<EasyRefreshState>();
GlobalKey<RefreshHeaderState> _headerKey = new GlobalKey<RefreshHeaderState>();
GlobalKey<RefreshFooterState> _footerKey = new GlobalKey<RefreshFooterState>();
Widget headerGrid = ClassicsHeader(
  key: _headerKey,
  refreshText: '下拉刷新',
  refreshReadyText: '释放即可刷新',
  refreshingText: '刷新中...',
  refreshedText: '完成',
  bgColor: Colors.transparent,
  textColor: Colors.black87,
  moreInfoColor: Colors.black54,
  showMore: true,
);
Widget footerGrid = ClassicsFooter(
  key: _footerKey,
  loadText: '上拉加载',
  loadReadyText: '释放加载',
  loadingText: '加载中',
  loadedText: '加载完成',
  noMoreText: '无数据',
  bgColor: Colors.transparent,
  textColor: Colors.black87,
  moreInfoColor: Colors.black54,
  showMore: true,
);
List<Map> userInfoList = [
  {
    'name': 'kuaifengle',
    'id': 1076820548,
    'checkInfo': 'https://github.com/kuaifengle',
    'lastTime': '20.11',
    'imageUrl':
        'https://image.lingcb.net/goods/201812/2ad6f1b0-2b2c-4d71-8d0d-01679e298afc-150x150.png',
    'backgroundUrl':
        'http://pic31.photophoto.cn/20140404/0005018792087823_b.jpg'
  },
  {
    'name': 'Only',
    'id': 186505022,
    'checkInfo': '砖石一颗即永恒',
    'lastTime': '16.18',
    'imageUrl':
        'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1667994205,255365672&fm=5',
    'backgroundUrl':
        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=ccd0b58aa181af2a0ef5dfc44266fde2&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D0f22919fb8b7d0a26fc40cdea3861c7c%2F0df431adcbef7609e92064b224dda3cc7cd99ef0.jpg'
  },
  {
    'name': '哈哈',
    'id': 34465,
    'checkInfo': '呵呵',
    'lastTime': '24.00',
    'imageUrl':
        'https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=2406161785,701397900&fm=5',
    'backgroundUrl':
        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=dd17c39c2f725d8e3f4fd69a668c5d9b&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimage%2Fc0%253Dshijue1%252C0%252C0%252C294%252C40%2Fsign%3D93cf8a986f380cd7f213aaaec92dc741%2F902397dda144ad347a33f2afdaa20cf431ad850d.jpg'
  },
  {
    'name': '呵呵',
    'id': 445644564,
    'checkInfo': '干嘛,呵呵, 去洗澡',
    'lastTime': '10.20',
    'imageUrl':
        'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=1853832225,307688784&fm=5',
    'backgroundUrl':
        'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1544591217574&di=2189213cef3d70c482f52359d2727d15&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F810a19d8bc3eb13584856f6fac1ea8d3fc1f44a0.jpg'
  },
  {
    'name': 'Dj',
    'id': 5,
    'checkInfo': '如果我是Dj你会爱我吗',
    'lastTime': '19.28',
    'imageUrl':
        'https://ss0.baidu.com/6ONWsjip0QIZ8tyhnq/it/u=2247692397,1189743173&fm=5',
    'backgroundUrl': ''
  }
];

class _MessageContactsPageState extends State<MessageContactsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0.5,
          title: Text(
            "消息",
            style: TextStyle(
                fontSize: GlobalConstant.middleTextWhiteSize,
                fontWeight: FontWeight.w600),
          ),
//          backgroundColor: GlobalColors.ChatThemeColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.contacts),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {},
            )
          ],
        ),
        preferredSize: Size.fromHeight(ScreenUtil.designTopBarHeight),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: EasyRefresh(
              key: _easyRefreshKey,
              builder: (context, child, scrollController) {
                return Scrollbar(child: child);
              },
              refreshHeader: headerGrid,
              refreshFooter: footerGrid,
              child: ListView.builder(
                  itemCount: userInfoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return returnUserItem(userInfoList[index]);
                  }),
              onRefresh: () {},
              loadMore: () {},
            ),
          )
        ],
      ),
    );
  }

  returnUserItem(item) {
    return new GestureDetector(
      child: new Slidable(
        controller: slidableController,
        delegate: new SlidableDrawerDelegate(),
        actionExtentRatio: 0.2,
        child: new Container(
          decoration: new BoxDecoration(
              border: new BorderDirectional(
                  bottom:
                      new BorderSide(color: Color(0xFFe1e1e1), width: 1.0))),
          child: InkWell(
            splashColor: Colors.grey,
            onTap: () {
                NavigatorUtils.gotoMessageTalkingPage(context);
            },
            child: new ListTile(
              leading: new CircleAvatar(
                backgroundImage: new NetworkImage('${item['imageUrl']}'),
              ),
              title: new Text('${item['name']}'),
              subtitle: new Text('${item['checkInfo']}'),
              trailing: new Text('${item['lastTime']}'),
            ),
          ),
        ),
        secondaryActions: <Widget>[
          new IconSlideAction(
              caption: '置顶',
              color: Colors.grey,
              foregroundColor: Colors.white,
              icon: Icons.vertical_align_top,
              onTap: () {}),
          new IconSlideAction(
            caption: '删除',
            color: Colors.red,
            icon: Icons.delete_outline,
            onTap: () => ToastUtils.info(context, '成功删除'),
          ),
        ],
      ),
    );
  }
}
