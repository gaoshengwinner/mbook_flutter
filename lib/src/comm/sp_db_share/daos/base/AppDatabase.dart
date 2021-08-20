import 'dart:async';
import 'package:floor/floor.dart';
import 'package:mbook_flutter/src/comm/sp_db_share/entities/BaseTemplate.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:mbook_flutter/src/comm/sp_db_share/daos/BaseTemplateDao.dart';

part 'AppDatabase.g.dart'; // the generated code will be there

@Database(version: 1, entities: [BaseTemplate])
abstract class AppDatabase extends FloorDatabase {


  BaseTemplateDao get baseTemplateDao;


}
