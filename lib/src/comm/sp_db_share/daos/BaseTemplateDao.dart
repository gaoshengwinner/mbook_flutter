import 'package:floor/floor.dart';
import 'package:mbook_flutter/src/comm/sp_db_share/daos/base/AppDatabase.dart';
import 'package:mbook_flutter/src/comm/sp_db_share/entities/BaseTemplate.dart';
import 'package:uuid/uuid.dart';

import 'base/DBManager.dart';

@dao
abstract class BaseTemplateDao {
  @Query('SELECT * FROM ${BaseTemplate.table_name}')
  Future<List<BaseTemplate>> findAllBaseTemplates();

  @Query(
      'SELECT * FROM ${BaseTemplate.table_name} WHERE ${BaseTemplate.table_id} = :id')
  Future<BaseTemplate?> findById(String id);

  @insert
  Future<void> insertData(BaseTemplate entity);

  @delete
  Future<void> deleteData(BaseTemplate entity);

  @Query('DELETE FROM ${BaseTemplate.table_name} ')
  Future<void> deleteAllData();

  @update
  Future<void> updateData(BaseTemplate entity);

  @transaction
  Future<void> insetOrUpdateData(BaseTemplate entity) async {
    bool willBeInsert = false;
    if (entity.baseTemplateId == null) {
      willBeInsert = true;
      entity.baseTemplateId = Uuid().v4();
    } else {
      BaseTemplate? baseTemplate = await findById(entity.baseTemplateId!);
      if (baseTemplate == null) {
        willBeInsert = true;
      }
    }
    if (willBeInsert) {
      insertData(entity);
    } else {
      updateData(entity);
    }
  }

  static Future<BaseTemplateDao> ins() async {
    AppDatabase db = await DBManager.open();
    return db.baseTemplateDao;
  }
}
