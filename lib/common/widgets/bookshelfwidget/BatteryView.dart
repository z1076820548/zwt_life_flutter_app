import 'dart:async';

import 'package:flutter/material.dart';
import 'package:battery/battery.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';

double batteryLevel = 0;

class BatteryView extends StatefulWidget {
  @override
  _BatteryViewState createState() => _BatteryViewState();
}

class _BatteryViewState extends State<BatteryView> {
  Color batteryColor = Colors.green;
  Timer _timer;

  @override
  void dispose() {
    // TODO: implement dispose
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (batteryLevel == 0) {
      getBatteryLevel();
    }
    _timer = Timer.periodic(Duration(seconds: 3), (timer) async {
      getBatteryLevel();
    });
  }

  getBatteryLevel() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidInfo = await deviceInfo.androidInfo;
      if (!androidInfo.isPhysicalDevice) {
        return;
      }
    }
    if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;
      if (!iosInfo.isPhysicalDevice) {
        return;
      }
    }

//    Battery().onBatteryStateChanged.listen((BatteryState state) {});
    var level = await Battery().batteryLevel;
    setState(() {
      batteryLevel = level / 100.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 27,
      height: 10,
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset(
                'static/images/reader_battery.png',
                color: Colors.black54,
              ),
              Container(
                color: Colors.black54,
                margin: EdgeInsets.fromLTRB(2, 2, 2, 2),
                width: 20 * batteryLevel,
              )
            ],
          ),
        ],
      ),
    );
  }
}
