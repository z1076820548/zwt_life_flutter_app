import 'dart:io';

import 'package:intl/intl.dart';
import 'dart:async';
//import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class SoundUtils {
//  static FlutterSound flutterSound;
//
//  static SoundUtils instance = new SoundUtils();
//
//  static StreamSubscription _recorderSubscription,
//      _playerSubscription,
//      _dbPeakSubscription;
//
//  static SoundUtils getInstance() {
//    return instance;
//  }
//
//  SoundUtils() {
//    flutterSound = new FlutterSound();
//
//    /// 0.01 is default
//    flutterSound.setSubscriptionDuration(0.01);
//    //// By default this option is disabled, you can enable it by calling
//    flutterSound.setDbLevelEnabled(true);
//  }
//
//  void startRecorder({String uri}) async {
//    print("录音开始");
//    String path = await flutterSound.startRecorder(uri);
//    print('startRecorder: $path');
////    _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
////      DateTime date =
////          new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
////      String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
////    });
//  }
//
//  Future<String> getPath(String name) async {
//    // 获取应用目录
//    String dir = (await getApplicationDocumentsDirectory()).path;
//    return ('$dir/$name');
//  }
//
//  void stopRecorder() async {
//    print("录音结束");
//    String result = await flutterSound.stopRecorder();
//    if (_recorderSubscription != null) {
//      _recorderSubscription.cancel();
//      _recorderSubscription = null;
//    }
//  }
//
//  void startPlayer({String uri}) async {
//    String path = await flutterSound.startPlayer(uri);
//    print('startPlayer: $path');
//
////    _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
////      if (e != null) {
////        DateTime date =
////            new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
////        String txt = DateFormat('mm:ss:SS', 'en_US').format(date);
////      }
////    });
//  }
//
//  stopPlayer() async {
//    String result = await flutterSound.stopPlayer();
//    print('stopPlayer: $result');
//    if (_playerSubscription != null) {
//      _playerSubscription.cancel();
//      _playerSubscription = null;
//    }
//  }
//
//  pausePlayer() async {
//    String result = await flutterSound.pausePlayer();
//  }
//
//  resumePlayer() async {
//    String result = await flutterSound.resumePlayer();
//  }
//
//  seekPlayer(int miliSecs) async {
//    String result = await flutterSound.seekToPlayer(miliSecs);
//  }
//
//  settingVolume({String uri, double volume = 0.1}) async {
//    /// 1.0 is default
//    /// Currently, volume can be changed when player is running. Try manage this right after player starts.
//    String path = await flutterSound.startPlayer(uri);
//    await flutterSound.setVolume(volume);
//  }
////// You need to subscribe in order to receive the value updates
////  _dbPeakSubscription = flutterSound.onRecorderDbPeakChanged.listen((value) {
////  setState(() {
////  this._dbLevel = value;
////  });
////  });

}
