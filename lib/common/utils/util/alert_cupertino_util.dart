
import 'package:flutter/cupertino.dart';

class AlertCupertinoUtil{
  static void showAletWithTitle(BuildContext context,{var title : '提示',var contentText : "",var allowText : '确定',var cancleText : '取消', VoidCallback onAllow,VoidCallback onCancle,bool isDestructiveAction:false}){
    showDemoDialog(
      context: context,
      child: CupertinoAlertDialog(
        title:  Text('$title'),
        content:  Text('$contentText'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('$cancleText'),
            onPressed: () {
              Navigator.pop(context, '$cancleText');
              onCancle();
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: isDestructiveAction,
            child:  Text('$allowText'),
            onPressed: () {
              Navigator.pop(context, '$allowText');
              onAllow();
            },
          ),
        ],
      ),
    );
  }




 static void showDemoDialog({BuildContext context, Widget child}) {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value != null) {
      }
    });
  }

  static void showDemoActionSheet({BuildContext context, Widget child}) {
    showCupertinoModalPopup<String>(
      context: context,
      builder: (BuildContext context) => child,
    ).then((String value) {
      if (value != null) {
      }
    });
  }
}