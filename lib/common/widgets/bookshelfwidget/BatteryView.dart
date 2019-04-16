import 'package:flutter/material.dart';
import 'package:battery/battery.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';

class BatteryView extends StatefulWidget {
  @override
  _BatteryViewState createState() => _BatteryViewState();
}

class _BatteryViewState extends State<BatteryView>{
  double batteryLevel = 0;
  Color batteryColor = Colors.green;
  @override
  void initState() {
    super.initState();
    getBatteryLevel();

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

    Battery().onBatteryStateChanged.listen((BatteryState state) {});
    var level = await Battery().batteryLevel;
      setState(() {
        this.batteryLevel = level / 100.0;
      });

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 27,
      height: 12,
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Image.asset('static/images/reader_battery.png',color: Colors.black54,),
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
