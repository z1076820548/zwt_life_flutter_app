import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';
import 'package:zwt_life_flutter_app/common/utils/CommonUtils.dart';

//IOS弹窗
class MyCupertinoDialog extends StatefulWidget {
  final String title;
  final String content;
  final String cancleText;
  final String confirmText;
  final VoidCallback canclePress;
  final VoidCallback confirmPress;

  const MyCupertinoDialog(
      {Key key,
      this.title,
      this.content,
      this.cancleText,
      this.confirmText,
      this.canclePress,
      this.confirmPress})
      : super(key: key);

  @override
  _MyCupertinoDialogState createState() {
    // TODO: implement createState
    return new _MyCupertinoDialogState();
  }
}

class _MyCupertinoDialogState extends State<MyCupertinoDialog> {
  String lastSelectedValue;

  void showDemoDialog({BuildContext context, Widget child}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value != null) {
        setState(() {
          lastSelectedValue = value;
        });
      }
    });
  }

  void showDemoActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value != null) {
        setState(() {
          lastSelectedValue = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CupertinoAlertDialog(
      title: Text(widget.title ?? ''),
      content: Text(widget.content ?? ''),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(
              widget.cancleText ?? CommonUtils.getLocale(context).app_cancel),
          isDestructiveAction: true,
          onPressed: widget.canclePress ??
              () {
                Navigator.pop(
                    context,
                    widget.cancleText ??
                        CommonUtils.getLocale(context).app_cancel);
              },
        ),
        CupertinoDialogAction(
          child:
              Text(widget.confirmText ?? CommonUtils.getLocale(context).app_ok),
          isDestructiveAction: true,
          onPressed: widget.confirmPress ??
              () {
                Navigator.pop(
                    context,
                    widget.confirmPress ??
                        CommonUtils.getLocale(context).app_ok);
              },
        ),
      ],
    );
  }
}
