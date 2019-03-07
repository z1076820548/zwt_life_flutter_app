import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';

class PullLoadWidget extends StatefulWidget {
  //item渲染
  final IndexedWidgetBuilder itemBuilder;

  //加载更多回调
  final RefreshCallback onLoadMore;

  //下拉刷新回调
  final RefreshCallback onRefresh;

  //控制器，比如数据和一些配置
  final PullLoadWidgetControl control;

  final Key refreshKey;

  const PullLoadWidget(
      this.control, this.itemBuilder, this.onLoadMore, this.onRefresh,
      {Key key, this.refreshKey})
      : super(key: key);

  @override
  _PullLoadWidgetState createState() {
    // TODO: implement createState
    return _PullLoadWidgetState(this.control, this.itemBuilder, this.onRefresh,
        this.onLoadMore, this.refreshKey);
  }
}

class _PullLoadWidgetState extends State<PullLoadWidget> {
  final IndexedWidgetBuilder itemBuilder;

  final RefreshCallback onLoadMore;

  final RefreshCallback onRefresh;

  final Key refreshKey;

  PullLoadWidgetControl control;

  _PullLoadWidgetState(this.control, this.itemBuilder, this.onRefresh,
      this.onLoadMore, this.refreshKey);

  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(() {
      //判断当前滑动位置是不是到达底部，触发加载更多回调
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (this.control.needLoadMore) {
          this.onLoadMore?.call();
        }
      }
    });
  }

  //根据配置状态返回实际列表数量
  //实际上这里可以根据你的需要做更多的处理
  //比如多个头部，是否需要空白页，是否需要显示加载更多
  _getListCount() {
    //是否需要头部
    if (control.needHeader) {
      //如果需要头部，用Item0 的Widget作为ListView的头部
      //列表数量大于0时，因为头部和底部加载更多选项，需要对列表数据总数+2
      return (control.dataList.length > 0)
          ? control.dataList.length + 2
          : control.dataList.length + 1;
    } else {
      //如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
      if (control.dataList.length == 0) {
        return 1;
      }

      //如果有数据，因为底部加载更多选项，需要对列表数据总数+1
      return (control.dataList.length > 0)
          ? control.dataList.length + 1
          : control.dataList.length;
    }
  }

  //根据配置状态返回实际列表渲染Item
  _getItem(int index) {
    if (!control.needHeader &&
        index == control.dataList.length &&
        control.dataList.length != 0) {
      //如果不需要头部，并且数据不为0，当index等于数据长度时，渲染加载更多Item(因为index是从0开始)
      return _buildProgressIndicator();
    } else if (control.needHeader &&
        index == _getListCount() - 1 &&
        control.dataList.length != 0) {
      //如果需要头部，并且数据不为0，当index等于实际长度-1时，渲染加载更多Item(因为index是从0开始)
      return _buildProgressIndicator();
    }else if(!control.needHeader && index == _getListCount() -1 && control.dataList.length !=0){
      ///如果不需要头部，并且数据为0，渲染空页面
      return _buildEmpty();
    }else{
      ///回调外部正常渲染 Item,如果这里有需要，可以直接返回相对位置的index
      return itemBuilder(context,index);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

///空白页面
Widget _buildEmpty(){
  return Container(
    height: MediaQuery.of(context).size.height -100,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          onPressed: (){},
          child: Image(image: AssetImage(GlobalIcons.USER_ITEM_COMPANY),),
        )
      ],
    ),
  );
}

class PullLoadWidgetControl {
  ///数据，对齐增减，不能替换
  List dataList = new List();

  ///是否需要加载更多
  bool needLoadMore = true;

  ///是否需要头部
  bool needHeader = false;
}
