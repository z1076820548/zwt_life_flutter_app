import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:zwt_life_flutter_app/widget/otherwidget/tip/TipDialog.dart';

//仿ios提示框
class TipUtil {
  static BuildContext mContext;

  static dismiss() {
    Navigator.pop(mContext);
  }

  static Future<Null> nothing(BuildContext context, String tip) {
    mContext = context;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return TipDialog(
            type: TipDialogType.NOTHING,
            tip: tip,
          );
        });
  }

  static Future<Null> Loading(BuildContext context, String tip) {
    mContext = context;
    return showCustomDialog(
        context: context,
        builder: (BuildContext context) {
          return TipDialog(
            type: TipDialogType.LOADING,
            tip: tip,
          );
        });
  }

  static Future<Null> Fail(BuildContext context, String tip) {
    mContext = context;
    return showCustomDialog(
        context: context,
        builder: (BuildContext context) {
          return TipDialog(
            type: TipDialogType.FAIL,
            tip: tip,
          );
        });
  }

  static Future<Null> Success(BuildContext context, String tip) {
    mContext = context;
    return showCustomDialog(
        context: context,
        builder: (BuildContext context) {
          return TipDialog(
            type: TipDialogType.SUCCESS,
            tip: tip,
          );
        });
  }

  static Future<Null> Info(BuildContext context, String tip) {
    mContext = context;
    return showCustomDialog(
        context: context,
        builder: (BuildContext context) {
          return TipDialog(
            type: TipDialogType.INFO,
            tip: tip,
          );
        });
  }

  static Future<T> showCustomDialog<T>({
    @required
        BuildContext context,
    bool barrierDismissible = true,
    @Deprecated(
        'Instead of using the "child" argument, return the child from a closure '
        'provided to the "builder" argument. This will ensure that the BuildContext '
        'is appropriate for widgets built in the dialog.')
        Widget child,
    WidgetBuilder builder,
  }) {
    assert(child == null || builder == null);
    assert(debugCheckHasMaterialLocalizations(context));

    final ThemeData theme = Theme.of(context, shadowThemeOnly: true);
    return showGeneralDialog(
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = child ?? Builder(builder: builder);
        return SafeArea(
          child: Builder(builder: (BuildContext context) {
            return theme != null
                ? Theme(data: theme, child: pageChild)
                : pageChild;
          }),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      //不想使用黑色遮罩层 所以颜色调低
      barrierColor: Colors.black12,
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions,
    );
  }

  static Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );
  }
}
