import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//带图标的输入框
class MyTextField extends StatefulWidget {
  final bool autofocus;
  final bool obscureText;
  final String hintText;
  final IconData iconData;
  final ValueChanged<String> onChanged;
  final TextStyle textStyle;
  final TextEditingController controller;
  final Color textColor;
  final Color iconColor;

  MyTextField(
      {Key key,
      this.autofocus = false,
      this.obscureText = false,
      this.hintText,
      this.iconData,
      this.onChanged,
      this.textStyle,
      this.controller,
      this.textColor,
      this.iconColor})
      : super(key: key);

  @override
  _MyTextFieldState createState() {
    // TODO: implement createState
    return _MyTextFieldState();
  }
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new TextField(
      style:
          TextStyle(color: widget.textColor == null ? null : widget.textColor),
      controller: widget.controller,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      decoration: new InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(

            decorationColor:widget.textColor == null ? null : widget.textColor,
            color: widget.textColor == null ? null : widget.textColor),
        icon: widget.iconData == null
            ? null
            : Icon(widget.iconData,
                color: widget.iconColor == null ? null : widget.iconColor),
      ),
    );
  }
}
