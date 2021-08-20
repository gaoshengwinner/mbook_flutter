// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BaseTemplateDao? _baseTemplateDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `BaseTemplate` (`baseTemplateId` TEXT, `json` TEXT, PRIMARY KEY (`baseTemplateId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BaseTemplateDao get baseTemplateDao {
    return _baseTemplateDaoInstance ??=
        _$BaseTemplateDao(database, changeListener);
  }
}

class _$BaseTemplateDao extends BaseTemplateDao {
  _$BaseTemplateDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _baseTemplateInsertionAdapter = InsertionAdapter(
            database,
            'BaseTemplate',
            (BaseTemplate item) => <String, Object?>{
                  'baseTemplateId': item.baseTemplateId,
                  'json': item.json
                }),
        _baseTemplateUpdateAdapter = UpdateAdapter(
            database,
            'BaseTemplate',
            ['baseTemplateId'],
            (BaseTemplate item) => <String, Object?>{
                  'baseTemplateId': item.baseTemplateId,
                  'json': item.json
                }),
        _baseTemplateDeletionAdapter = DeletionAdapter(
            database,
            'BaseTemplate',
            ['baseTemplateId'],
            (BaseTemplate item) => <String, Object?>{
                  'baseTemplateId': item.baseTemplateId,
                  'json': item.json
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BaseTemplate> _baseTemplateInsertionAdapter;

  final UpdateAdapter<BaseTemplate> _baseTemplateUpdateAdapter;

  final DeletionAdapter<BaseTemplate> _baseTemplateDeletionAdapter;

  @override
  Future<List<BaseTemplate>> findAllBaseTemplates() async {
    return _queryAdapter.queryList('SELECT * FROM BaseTemplate',
        mapper: (Map<String, Object?> row) => BaseTemplate(
            baseTemplateId: row['baseTemplateId'] as String?,
            json: row['json'] as String?));
  }

  @override
  Future<BaseTemplate?> findById(String id) async {
    return _queryAdapter.query(
        'SELECT * FROM BaseTemplate WHERE baseTemplateId = ?1',
        mapper: (Map<String, Object?> row) => BaseTemplate(
            baseTemplateId: row['baseTemplateId'] as String?,
            json: row['json'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteAllData() async {
    await _queryAdapter.queryNoReturn('DELETE FROM BaseTemplate');
  }

  @override
  Future<void> insertData(BaseTemplate entity) async {
    await _baseTemplateInsertionAdapter.insert(
        entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateData(BaseTemplate entity) async {
    await _baseTemplateUpdateAdapter.update(entity, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteData(BaseTemplate entity) async {
    await _baseTemplateDeletionAdapter.delete(entity);
  }

  @override
  Future<void> insetOrUpdateData(BaseTemplate entity) async {
    if (database is sqflite.Transaction) {
      await super.insetOrUpdateData(entity);
    } else {
      await (database as sqflite.Database)
          .transaction<void>((transaction) async {
        final transactionDatabase = _$AppDatabase(changeListener)
          ..database = transaction;
        await transactionDatabase.baseTemplateDao.insetOrUpdateData(entity);
      });
    }
  }
}
