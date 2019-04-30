import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zwt_life_flutter_app/widget/otherwidget/tip/TipDialog.dart';

class TipUtil {
  static Future<Null> nothing(BuildContext context, String tip) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return TipDialog(
            type: TipDialogType.NOTHING,
            tip: tip,
          );
        });
  }
}
