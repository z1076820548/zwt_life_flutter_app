import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
class BookShelfPage extends StatefulWidget {
  static final String sName = "BookShelf";

  @override
  _BookShelfPageState createState() {
    // TODO: implement createState
    return _BookShelfPageState();
  }
}

class _BookShelfPageState extends State<BookShelfPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('书架'),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Semantics(
              child: Icon(CupertinoIcons.search, color: Colors.black),
            ),
          ),
        ),
        child: DefaultTextStyle(
          style: CupertinoTheme.of(context).textTheme.textStyle,
          child: SafeArea(
            child: Center(
              child: CupertinoScrollbar(
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  child: ListView() Text('4554'),
                ),
              ),
            ),
          ),
        ));
  }
}
