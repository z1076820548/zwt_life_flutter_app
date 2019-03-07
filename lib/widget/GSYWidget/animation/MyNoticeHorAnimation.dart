import 'package:flutter/material.dart';
import 'package:zwt_life_flutter_app/common/style/GlobalStyle.dart';

//公告栏动画 水平淡入淡出
class MyNoticeHorAnimation extends StatefulWidget {
  final Duration duration;
  final List<String> messages;

  const MyNoticeHorAnimation({
    Key key,
    this.duration = const Duration(milliseconds: 3000),
    this.messages,
  }) : super(key: key);

  @override
  _MyNoticeHorAnimationState createState() {
    // TODO: implement createState
    return _MyNoticeHorAnimationState();
  }
}

class _MyNoticeHorAnimationState extends State<MyNoticeHorAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;

  int _nextMassage = 0;

  //透明度
  Animation<double> _opacityAni1, _opacityAni2;

  //位移
  Animation<Offset> _positionAni1, _positionAni2;

  @override
  void initState() {
    _startHorizontalAni();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //正向开启动画
    // TODO: implement build
    return SlideTransition(
      position: _positionAni2,
      child: FadeTransition(
        opacity: _opacityAni2,
        child: SlideTransition(
          position: _positionAni1,
          child: FadeTransition(
            opacity: _opacityAni1,
            child: Text(
              widget.messages[_nextMassage],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GlobalConstant.middleText,
            ),
          ),
        ),
      ),
    );
  }

  //横向滚动
  void _startHorizontalAni() {
    // TODO: implement initState
    _controller = AnimationController(duration: widget.duration, vsync: this);

    _opacityAni1 = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.0, 0.0, curve: Curves.linear)),
    );

    _opacityAni2 = Tween<double>(begin: 1.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.0, 0.0, curve: Curves.linear)),
    );

    _positionAni1 = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.0, 0.5, curve: Curves.linear)),
    );

    _positionAni2 = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: const Offset(-1.0, 0.0),
    ).animate(
      CurvedAnimation(
          parent: _controller, curve: Interval(0.5, 1.0, curve: Curves.linear)),
    );

    _controller
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _nextMassage++;
            if (_nextMassage >= widget.messages.length) {
              _nextMassage = 0;
            }
          });
          _controller.reset();
          _controller.forward();
        }
        if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  //释放
  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
