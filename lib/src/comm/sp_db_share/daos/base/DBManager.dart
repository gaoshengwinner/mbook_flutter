import 'package:mbook_flutter/src/comm/sp_db_share/daos/base/AppDatabase.dart';

class DBManager {
  static const _database_name = "fb_db";
  static AppDatabase? _database;

  static Future<AppDatabase> open() async {
    if (_database == null)
      _database =
          await $FloorAppDatabase.databaseBuilder(_database_name).build();
    return _database!;
  }

  static close() async {
    if (_database != null) _database!.close();
    _database = null;
  }
}
