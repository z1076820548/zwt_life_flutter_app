import 'package:flutter/material.dart';

//充满的Button
class MyRaisedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPress;
  final double fontSize;
  final int maxLines;
  final MainAxisAlignment mainAxisAlignment;
  final ShapeBorder shape;
  const MyRaisedButton({
    Key key,
    this.shape,
    this.text,
    this.color,
    this.textColor,
    this.onPress,
    this.fontSize = 20.0,
    this.maxLines = 1,
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new RaisedButton(
      padding:
      new EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0, bottom: 10.0),
      textColor: textColor,
      color: color,
      shape: shape == null
          ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))
          : shape,
      child: new Flex(
        mainAxisAlignment: mainAxisAlignment,
        direction: Axis.horizontal,
        children: <Widget>[
          new Text(
            text,
            style: new TextStyle(fontSize: fontSize),
            maxLines: maxLines,
            overflow:TextOverflow.ellipsis,
          )
        ],
      ),
      onPressed: (){
        this.onPress?.call();
      },
    );
  }
}
