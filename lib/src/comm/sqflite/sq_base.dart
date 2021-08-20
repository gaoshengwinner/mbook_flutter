// import 'dart:async';
// import 'dart:html';
//
// import 'package:flutter/widgets.dart';
//
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// class DBManager {
//   static const int _VERSION = 1;
//   static const String _DB_NAME = "fb_database.db";
//   static Database? _database;
//
//   static _init() async {
//     _database = await openDatabase(
//       join(await getDatabasesPath(), _DB_NAME),
//       onCreate: (db, version) async {
//         // await db.execute(
//         //   'CREATE TABLE base_template(id TEXT PRIMARY KEY, json TEXT)',
//         // );
//       },
//       version: _VERSION,
//     );
//   }
//
//   static Future<Database> getDatabase() async {
//     if (_database == null) {
//       await _init();
//     }
//     return _database!;
//   }
//
//   static Future<bool> isTableExits(String tableName) async {
//     await getDatabase();
//     final String checkSql =
//         "select 1 from Sqlite_master where type='table' and name ='${tableName}'";
//     final res = await _database!.rawQuery(checkSql);
//     return res.length > 0;
//   }
//
//   static close() {
//     _database?.close();
//   }
// }
//
// abstract class BaseDBProvider {
//   String tableName;
//   String createSql;
//
//   BaseDBProvider({required this.tableName, required this.createSql});
//
//   bool isMustTableExits = false;
//
//   @mustCallSuper
//   Future<void> prepare() async {
//     isMustTableExits = await DBManager.isTableExits(tableName);
//     if (!isMustTableExits) {
//       await (await DBManager.getDatabase()).execute(createSql);
//     }
//   }
//
//   @mustCallSuper
//   Future<Database> open() async {
//     if (!isMustTableExits) {
//       await prepare();
//     }
//     return await DBManager.getDatabase();
//   }
//
//   Future<Database> getDatabase() async {
//     return await open();
//   }
// }
