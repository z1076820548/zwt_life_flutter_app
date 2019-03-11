import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/CommonUtils.dart';

class MySearchInputWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onSubmitPressed;

  const MySearchInputWidget(
      {Key key, this.onChanged, this.onSubmitted, this.onSubmitPressed})
      : super(key: key);

  @override
  _MySearchInputWidgetState createState() {
    // TODO: implement createState
    return _MySearchInputWidgetState();
  }
}

class _MySearchInputWidgetState extends State<MySearchInputWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 0.3),
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 4.0)]),
      padding:
          EdgeInsets.only(left: 20.0, top: 12.0, right: 20.0, bottom: 12.0),
      child: Row(
        children: <Widget>[
          RawMaterialButton(
            onPressed: (()=>{}),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Icon(Icons.search, color: Colors.black26),
            constraints: BoxConstraints(minWidth: 0.0, minHeight: 0.0),
          ),
          Expanded(
            child: TextField(
              autofocus: false,
              decoration: InputDecoration.collapsed(
                  hintText: CommonUtils.getLocale(context).repos_issue_search,
                  hintStyle: GlobalConstant.middleSubText),
              style: GlobalConstant.middleText,
              onChanged: widget.onChanged,
              onSubmitted: widget.onSubmitted,
            ),
          )
        ],
      ),
    );
  }
}
