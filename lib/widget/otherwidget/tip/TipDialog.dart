import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:zwt_life_flutter_app/widget/otherwidget/tip/LoadingView.dart';

enum TipDialogType { NOTHING, LOADING, SUCCESS, FAIL, INFO }

class TipDialog extends StatelessWidget {
//  TipDialog(
//      {Key key,
//      TipDialogType type: TipDialogType.NOTHING,
//      this.tip,
//      this.openMask: false})
//      : assert(type != null),
//        icon = type == TipDialogType.NOTHING ? null : new TipDialogIcon(type),
//        bodyBuilder = null,
//        color = const Color(0xcc000000),
//        super(key: key);
//
//  TipDialog.customIcon({Key key, this.icon, this.tip})
//      : assert(icon != null || tip != null),
//        bodyBuilder = null,
//        openMask = null,
//        color = const Color(0xbb000000),
//        super(key: key);
//
//
//  TipDialog.builder(
//      {Key key,
//      this.bodyBuilder,
//      this.color: const Color(0xbb000000),
//      this.openMask})
//      : assert(bodyBuilder != null),
//        tip = null,
//        icon = null,
//        super(key: key);

  final String tip;
  Widget icon;
  final WidgetBuilder bodyBuilder;
  final Color color;
  final TipDialogType type;

  TipDialog({this.type, this.tip, this.bodyBuilder, this.color}) {
    icon = type == TipDialogType.NOTHING ? null : new TipDialogIcon(type);
  }

  Widget _buildBody() {
    List<Widget> childs = [];
    if (icon != null) {
      childs.add(new Padding(
        padding: tip == null
            ? const EdgeInsets.all(20.0)
            : const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
        child: icon,
      ));
    }
    if (tip != null) {
      childs.add(new Padding(
        padding: icon == null
            ? const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0)
            : const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
        child: new Text(
          tip,
          textAlign: TextAlign.center,
          style: new TextStyle(color: Colors.white, fontSize: 15.0),
          textDirection: TextDirection.ltr,
        ),
      ));
    }
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: childs,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type : MaterialType.transparency,
      child: Center(
        child: new ClipRRect(
          borderRadius: new BorderRadius.circular(15.0),
          child: new Container(
            constraints: icon == null || tip == null
                ? new BoxConstraints(minHeight: 50.0, minWidth: 100.0)
                : new BoxConstraints(minHeight: 90.0, minWidth: 120.0),
            color: color == null ? Colors.black87 : color,
            child: bodyBuilder == null ? _buildBody() : bodyBuilder(context),
          ),
        ),
      ),
    );
  }
}

class TipDialogIcon extends StatelessWidget {
  TipDialogIcon(this.type, {this.color: Colors.white});

  final TipDialogType type;
  final Color color;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case TipDialogType.SUCCESS:
        return new Icon(
          Icons.check_circle_outline,
          size: 35.0,
          color: color,
        );
      case TipDialogType.FAIL:
        return new Icon(
          Icons.sentiment_very_dissatisfied,
          size: 35.0,
          color: color,
        );
      case TipDialogType.INFO:
        return new Icon(
          Icons.info_outline,
          size: 35.0,
          color: color,
        );
      case TipDialogType.LOADING:
        return new LoadingView(
          35.0,
          color: color,
        );
      default:
        throw new Exception(
            "this type $type is not in TipDialogType: NOTHING, LOADING, SUCCESS, FAIL, INFO");
    }
  }
}
