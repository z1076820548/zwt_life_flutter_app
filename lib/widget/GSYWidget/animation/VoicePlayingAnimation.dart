import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/src/utils.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';

class VoicePlayingAnimation extends StatefulWidget {
  VoicePlayingAnimation({
    Key key,
    this.color,
    this.size = 5.0,
    this.itemBuilder,
    this.duration = const Duration(milliseconds: 1400),
    this.play = false,
  })  : assert(
            !(itemBuilder is IndexedWidgetBuilder && color is Color) &&
                !(itemBuilder == null && color == null),
            'You should specify either a itemBuilder or a color'),
        assert(size != null),
        super(key: key);

  final Color color;
  final double size;
  final IndexedWidgetBuilder itemBuilder;
  final Duration duration;
  final bool play;

  @override
  _VoicePlayingAnimationState createState() => _VoicePlayingAnimationState();
}

class _VoicePlayingAnimationState extends State<VoicePlayingAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _scaleCtrl;

  @override
  void initState() {
    super.initState();
    _scaleCtrl = AnimationController(vsync: this, duration: widget.duration)
      ..addListener(() {
        if (widget.play) {
          _scaleCtrl.forward();
        }else{
          _scaleCtrl.stop();
        }
      });
  }

  @override
  void dispose() {
    _scaleCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _circle(0, .0),
//        _circle(1, .2),
//        _circle(2, .4),
      ],
    );
  }

  Widget _circle(int index, double delay) {
    return ScaleTransition(
      scale: DelayTween(begin: 1.0, end: 0.5, delay: delay).animate(_scaleCtrl),
      child: _itemBuilder(index),
    );
  }

  Widget _itemBuilder(int index) {
    return widget.itemBuilder != null
        ? widget.itemBuilder(context, index)
        : Image(image: AssetImage("static/images/voice.png"), width: 20.0);
    ;
  }
}
