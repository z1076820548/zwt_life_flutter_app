import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';
import 'package:zwt_life_flutter_app/common/ab/provider/SqlManager.dart';

abstract class BaseDbProvider {
  bool isTableExits = false;

  tableSqlString();

  tableName();

  tableBaseString(String name, String columnId) {
    return '''
    create table $name (
    $columnId integer primary key autoincrement,''';
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), tableSqlString());
    }
    return await SqlManager.getCurrentDatabase();
  }

  @mustCallSuper
  prepare(tableName, tableSqlString) async {
    isTableExits = await SqlManager.isTableExits(tableName);
    if(!isTableExits){
      Database db = await SqlManager.getCurrentDatabase();
      return await db.execute(tableSqlString);
    }
  }
}
