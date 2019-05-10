import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provide/provide.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:zwt_life_flutter_app/common/net/Code.dart';
import 'package:zwt_life_flutter_app/page/MainPage.dart';
import 'package:zwt_life_flutter_app/public.dart';

//书籍缓存
class BookCachePage extends StatefulWidget {
  static final String sName = "BookCache";

  @override
  _BookCachePageState createState() {
    // TODO: implement createState
    return _BookCachePageState();
  }
}

class _BookCachePageState extends State<BookCachePage> {
  List<BookDetailBean> bookDetailBeanList = [];
  RefreshController _refreshController = new RefreshController();
  SlidableController slidableController = new SlidableController();

  @override
  void initState() {
    // TODO: implement initState
    initData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text('书籍缓存'),
      ),
      body: CupertinoScrollbar(
        child: bookDetailBeanList.length == 0
            ? Container(
                child: Text(''),
              )
            : SmartRefresher(
                controller: _refreshController,
                enablePullDown: false,
                enablePullUp: false,
                child: ListView.builder(
                    itemCount: bookDetailBeanList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return returnItem(bookDetailBeanList[index], index);
//                  return returnItem(recommendBooksList[index], index);
                    }),
              ),
      ),
    );
  }

  returnItem(BookDetailBean book, int index) {
    return Slidable(
      controller: slidableController,
      delegate: new SlidableDrawerDelegate(),
      actionExtentRatio: 0.2,
      secondaryActions: <Widget>[
        new IconSlideAction(
            caption: '删除',
            foregroundColor: Colors.red,
            color: Colors.grey[50],
            icon: Icons.delete_outline,
            onTap: () {
              delete(book, index);
            }),
      ],
      child: Material(
        child: Ink(
          child: InkWell(
            onTap: () {
//            tap(book);
            },
            child: Container(
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: ExtendedImage.network(
                      (Constant.IMG_BASE_URL + book.cover),
                      height: ScreenUtil.getInstance().L(50),
                      fit: BoxFit.fitHeight,
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      cache: true,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: new BoxDecoration(
                          border: new BorderDirectional(
                              bottom: new BorderSide(
                                  color: Color(0xFFe1e1e1), width: 0.5))),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topRight,
                            child: Provide<DownloadStatusEvent>(
                                builder: (context, child, downloadStatusEvent) {
                                  DownloadEvent downloadEvent;

                                  if(downloadEventList.length == 0){
                                    return Container();
                                  }
                                  for(int i = 0;i < downloadEventList.length;i++){
                                    if(book.id == downloadEventList[i].bookId){
                                      downloadEvent = downloadEventList[i];
                                      i = downloadEventList.length;
                                    }
                                  }
                              if (downloadEvent.bookId == book.id) {
                                if (downloadEvent.type ==
                                    DownloadEventType.pause) {
                                  return IconButton(
                                    alignment: Alignment.topRight,
                                    icon: Icon(Icons.file_download),
                                    onPressed: () {
                                      Code.eventBus.fire(new DownloadEvent(
                                          book.id,
                                          downloadEvent.list,
                                          downloadEvent.start,
                                          downloadEvent.end,
                                          DownloadEventType.start,
                                          current:
                                          downloadEvent.current));
                                    },
                                  );
                                }
                                if (downloadEvent.type ==
                                    DownloadEventType.loading) {
                                  return IconButton(
                                    alignment: Alignment.topRight,
                                    icon: Icon(Icons.pause),
                                    onPressed: () {
                                      Code.eventBus.fire(new DownloadEvent(
                                          book.id,
                                          downloadEvent.list,
                                          downloadEvent.start,
                                          downloadEvent.end,
                                          DownloadEventType.pause,
                                          current:
                                          downloadEvent.current));
                                    },
                                  );
                                }
                                if (downloadEvent.type ==
                                    DownloadEventType.finish) {
                                  return IconButton(
                                    alignment: Alignment.topRight,
                                    icon: Icon(
                                      Icons.check,
                                      color: GlobalColors.themeColor,
                                    ),
                                    onPressed: () {},
                                  );
                                }
                              }else{
                                return Container();
                              }
                            }),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  book.title,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          ScreenUtil.getInstance().setSp(16)),
                                ),
                              ),
                              Container(
                                child: Provide<DownloadStatusEvent>(
                                  builder:
                                      (context, child, downloadStatusEvent) {
                                        DownloadEvent downloadEvent;
                                        if(downloadEventList.length == 0){
                                          return Container();
                                        }
                                        for(int i = 0;i < downloadEventList.length;i++){
                                          if(book.id == downloadEventList[i].bookId){
                                            downloadEvent = downloadEventList[i];
                                            i = downloadEventList.length;
                                          }
                                        }
                                    if (downloadEvent.bookId == book.id) {
                                      int total = downloadEvent.end -
                                          downloadEvent.start;
                                      int current =
                                          downloadEvent.current -
                                              downloadEvent.start;
                                      double progress = current / total;
                                      return Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Text('第' +
                                                  '${downloadEvent.start + 1}章' +
                                                  '~' +
                                                  '第${downloadEvent.end + 1}章'),
                                              Text(
                                                '  缓存进度 ${(progress * 100.0).toStringAsFixed(1)}%',
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          ),
                                          LinearProgressIndicator(
                                            value: progress,
                                            backgroundColor: Colors.grey,
                                          ),
//                                  SizedBox(
//                                    width: 20.0,
//                                    height: 20.0,
//                                    child: CircularProgressIndicator(
//                                        value: progress),
//                                  ),
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void initData() async {
    bookDetailBeanList.clear();
    for (DownloadEvent downloadEvent in downloadEventList) {
      Data res = await dioGetBookDetail(downloadEvent.bookId);
      if (res.data != null && res.result) {
        bookDetailBeanList.add(res.data);
      }
    }
    setState(() {});
  }

  void delete(BookDetailBean book, int index) {
    bookDetailBeanList.removeAt(index);
    setState(() {});
    Code.eventBus.fire(new DownloadEvent(
        book.id, [], 0, 0, DownloadEventType.remove,
        current: 0));
  }
}
