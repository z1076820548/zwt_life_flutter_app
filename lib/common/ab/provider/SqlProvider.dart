import 'dart:async';
import 'dart:convert';

/**
 * 数据库表
 * Created by guoshuyu
 * Date: 2018-08-03
 */
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zwt_life_flutter_app/common/ab/provider/SqlManager.dart';

///基类
abstract class BaseDbProvider {
  bool isTableExits = false;

  tableSqlString();

  tableName();

  tableBaseString(String name, String columnId) {
    return '''
        create table $name (
        $columnId integer primary key autoincrement,
      ''';
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await SqlManager.isTableExits(name);
    if (!isTableExits) {
      Database db = await SqlManager.getCurrentDatabase();
      return await db.execute(createSql);
    }
  }

  @mustCallSuper
  open() async {
    isTableExits = await SqlManager.isTableExits(tableName());
    if (!isTableExits) {
      await prepare(tableName(), tableSqlString());
    }
    return await SqlManager.getCurrentDatabase();
  }
}
