import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/public.dart';

class BookDetailPage extends StatefulWidget {
  static final String sName = "BookDetailPage";
  final String bookId;

  const BookDetailPage({Key key, this.bookId}) : super(key: key);

  @override
  _BookDetailPageState createState() {
    // TODO: implement createState
    return _BookDetailPageState();
  }
}

class _BookDetailPageState extends State<BookDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 0), () async {
      await initData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('书籍详情'),
        actions: <Widget>[
          Center(
              child: GestureDetector(
            onTap: () {},
            child: Container(
                padding: EdgeInsets.only(right: 10), child: Text('全本缓存')),
          ))
        ],
      ),
      body: Center(
        child: CupertinoScrollbar(
          child: Container(
            child: Text('45456'),
          ),
        ),
      ),
    );
  }

  initData() async {
    await dioGetBookDetail(widget.bookId);
  }
}
