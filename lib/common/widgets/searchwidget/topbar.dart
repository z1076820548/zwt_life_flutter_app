import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/util/screen_util.dart';

class SearchTopBarLeadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child:
          Icon(Icons.keyboard_arrow_left, color: Color(0xFF979797), size: 26),
    );
  }
}

class SearchTopBarActionWidget extends StatelessWidget {
  final VoidCallback onActionTap;
  final String text;
//输入框焦点变化
  const SearchTopBarActionWidget({Key key, this.onActionTap, this.text,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: onActionTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          text,
          style: TextStyle(color: GlobalColors.themeColor),
        ),
      ),
    );
  }
}

class SearchTopBarTitleWidget extends StatelessWidget {
  final ValueChanged<String> textMessageSubmitted;
  final TextEditingController controller;
  final ValueChanged<String> listener;
  final FocusNode focusNode;

  const SearchTopBarTitleWidget(
      {Key key,
      this.textMessageSubmitted,
      this.controller,
      this.listener,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: ScreenUtil.searchTxtFieldHeight,
      padding: EdgeInsets.only(left: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: GlobalColors.divideLineColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            CupertinoIcons.search,
            color: GlobalColors.floorTitleColor,
            size: 20,
          ),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              onSubmitted: (s) {
                textMessageSubmitted(s);
              },
              textInputAction: TextInputAction.search,
              onChanged: (s) {
                listener(s);
              },
              cursorWidth: 1.5,
              autofocus: true,
              cursorColor: GlobalColors.floorTitleColor,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  hintText: "输入书名或作者名",
                  hintStyle: TextStyle(fontSize: 14),
                  border: InputBorder.none),
            ),
          ),
          controller.text.isEmpty
              ? Icon(null)
              : GestureDetector(
                  onTap: () {
                    controller.clear();
                    listener('');
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      CupertinoIcons.clear_circled,
                      color: GlobalColors.floorTitleColor,
                      size: 16,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
