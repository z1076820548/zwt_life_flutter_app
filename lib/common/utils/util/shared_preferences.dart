import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

/// 用来做shared_preferences的存储
class SpUtil {
  static SpUtil _instance;

  static Future<SpUtil> get instance async {
    return await getInstance();
  }

  static SharedPreferences _spf;

  SpUtil._();

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<SpUtil> getInstance() async {
    if (_instance == null) {
      _instance = new SpUtil._();
      await _instance._init();
    }
    return _instance;
  }

  static bool _beforeCheck() {
    if (_spf == null) {
      return true;
    }
    return false;
  }

  // 判断是否存在数据
  bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  Set<String> getKeys() {
    if (_beforeCheck()) return null;
    return _spf.getKeys();
  }

  get(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  getString(String key, String defaultVal) {
    if (_beforeCheck()) return null;
    if (_spf.getString(key) != null && _spf.getString(key).length > 0) {
      return _spf.getString(key);
    } else {
      return defaultVal;
    }
  }

  Future<bool> putString(String key, String value) {
    if (_beforeCheck()) return null;
    return _spf.setString(key, value);
  }

  bool getBool(String key, bool defaultVal) {
    if (_beforeCheck()) return null;
    if (_spf.getBool(key) != null) {
      return _spf.getBool(key);
    } else {
      return defaultVal;
    }
  }

  Future<bool> putBool(String key, bool value) {
    if (_beforeCheck()) return null;
    return _spf.setBool(key, value);
  }

  int getInt(String key, int defaultVal) {
    if (_beforeCheck()) return null;
    if (_spf.getInt(key) != null) {
      return _spf.getInt(key);
    } else {
      return defaultVal;
    }
  }

  Future<bool> putInt(String key, int value) {
    if (_beforeCheck()) return null;
    return _spf.setInt(key, value);
  }

  double getDouble(String key, double value) {
    if (_beforeCheck()) return null;
    if (_spf.getDouble(key) != null) {
      return _spf.getDouble(key);
    } else {
      return value;
    }
  }

  Future<bool> putDouble(String key, double value) {
    if (_beforeCheck()) return null;
    return _spf.setDouble(key, value);
  }

  List<String> getStringList(String key) {
    return _spf.getStringList(key);
  }

  Future<bool> putStringList(String key, List<String> value) {
    if (_beforeCheck()) return null;
    return _spf.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  Future<bool> remove(String key) {
    if (_beforeCheck()) return null;
    return _spf.remove(key);
  }

  Future<bool> clear() {
    if (_beforeCheck()) return null;
    return _spf.clear();
  }
}
