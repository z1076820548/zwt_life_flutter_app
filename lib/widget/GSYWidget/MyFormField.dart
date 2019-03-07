import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//带图标的表单输入框
class MyFormField extends StatefulWidget {
  final bool autofocus;
  final bool obscureText;
  final String hintText;
  final IconData iconData;
  final ValueChanged<String> onChanged;
  final TextStyle textStyle;
  final TextEditingController controller;
  //校验
  final FormFieldValidator<String> validator;

  MyFormField(
      {Key key,
      this.validator,
      this.autofocus = false,
      this.obscureText = false,
      this.hintText,
      this.iconData,
      this.onChanged,
      this.textStyle,
      this.controller})
      : super(key: key);

  @override
  _MyFormFieldState createState() {
    // TODO: implement createState
    return _MyFormFieldState();
  }
}

class _MyFormFieldState extends State<MyFormField> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextFormField(
      controller: widget.controller,
      autofocus: widget.autofocus,
      obscureText: widget.obscureText,
      decoration: new InputDecoration(
        hintText: widget.hintText,
        icon: widget.iconData == null ? null : new Icon(widget.iconData),
      ),
      validator: widget.validator,
    );
  }
}
