import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/widget/GSYWidget/search/SearchDemoSearchDelegate.dart';

class SearchPage extends StatefulWidget {
  static final String sName = "Search";

  @override
  _SearchPageState createState() {
    // TODO: implement createState
    return _SearchPageState();
  }
}

class _SearchPageState extends State<SearchPage> {
  final SearchDemoSearchDelegate _delegate = SearchDemoSearchDelegate();

  @override
  void initState() {
    showSearch<int>(
      context: context,
      delegate: _delegate,
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      body: Container(
      ),
    );
  }
}
