// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
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

  HabitDao? _habitDaoInstance;

  HabitDoneDatesDao? _habitDoneDatesDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
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
            'CREATE TABLE IF NOT EXISTS `HabitEntity` (`uid` TEXT NOT NULL, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `priority` INTEGER NOT NULL, `count` INTEGER NOT NULL, `type` INTEGER NOT NULL, `completeUntil` INTEGER NOT NULL, `createdAt` INTEGER NOT NULL, `color` INTEGER NOT NULL, PRIMARY KEY (`uid`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `HabitDoneDatesEntity` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `uid` TEXT NOT NULL, `date` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  HabitDao get habitDao {
    return _habitDaoInstance ??= _$HabitDao(database, changeListener);
  }

  @override
  HabitDoneDatesDao get habitDoneDatesDao {
    return _habitDoneDatesDaoInstance ??=
        _$HabitDoneDatesDao(database, changeListener);
  }
}

class _$HabitDao extends HabitDao {
  _$HabitDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _habitEntityInsertionAdapter = InsertionAdapter(
            database,
            'HabitEntity',
            (HabitEntity item) => <String, Object?>{
                  'uid': item.uid,
                  'title': item.title,
                  'description': item.description,
                  'priority': _habitPriorityConverter.encode(item.priority),
                  'count': item.count,
                  'type': _habitTypeConverter.encode(item.type),
                  'completeUntil':
                      _dateTimeConverter.encode(item.completeUntil),
                  'createdAt': _dateTimeConverter.encode(item.createdAt),
                  'color': item.color
                }),
        _habitEntityUpdateAdapter = UpdateAdapter(
            database,
            'HabitEntity',
            ['uid'],
            (HabitEntity item) => <String, Object?>{
                  'uid': item.uid,
                  'title': item.title,
                  'description': item.description,
                  'priority': _habitPriorityConverter.encode(item.priority),
                  'count': item.count,
                  'type': _habitTypeConverter.encode(item.type),
                  'completeUntil':
                      _dateTimeConverter.encode(item.completeUntil),
                  'createdAt': _dateTimeConverter.encode(item.createdAt),
                  'color': item.color
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HabitEntity> _habitEntityInsertionAdapter;

  final UpdateAdapter<HabitEntity> _habitEntityUpdateAdapter;

  @override
  Future<List<HabitEntity>> getAllHabits() async {
    return _queryAdapter.queryList('SELECT * FROM HabitEntity',
        mapper: (Map<String, Object?> row) => HabitEntity(
            uid: row['uid'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            priority: _habitPriorityConverter.decode(row['priority'] as int),
            count: row['count'] as int,
            type: _habitTypeConverter.decode(row['type'] as int),
            completeUntil:
                _dateTimeConverter.decode(row['completeUntil'] as int),
            createdAt: _dateTimeConverter.decode(row['createdAt'] as int),
            color: row['color'] as int));
  }

  @override
  Future<void> insertHabit(HabitEntity habit) async {
    await _habitEntityInsertionAdapter.insert(
        habit, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateHabit(HabitEntity habit) async {
    await _habitEntityUpdateAdapter.update(habit, OnConflictStrategy.abort);
  }
}

class _$HabitDoneDatesDao extends HabitDoneDatesDao {
  _$HabitDoneDatesDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _habitDoneDatesEntityInsertionAdapter = InsertionAdapter(
            database,
            'HabitDoneDatesEntity',
            (HabitDoneDatesEntity item) => <String, Object?>{
                  'id': item.id,
                  'uid': item.uid,
                  'date': _dateTimeConverter.encode(item.date)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<HabitDoneDatesEntity>
      _habitDoneDatesEntityInsertionAdapter;

  @override
  Future<List<HabitDoneDatesEntity>> findByHabitUid(String uid) async {
    return _queryAdapter.queryList(
        'SELECT * FROM HabitDoneDatesEntity WHERE uid = ?1',
        mapper: (Map<String, Object?> row) => HabitDoneDatesEntity(
            id: row['id'] as int?,
            uid: row['uid'] as String,
            date: _dateTimeConverter.decode(row['date'] as int)),
        arguments: [uid]);
  }

  @override
  Future<void> insertDoneDate(HabitDoneDatesEntity habitDoneDatesEntity) async {
    await _habitDoneDatesEntityInsertionAdapter.insert(
        habitDoneDatesEntity, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _habitPriorityConverter = HabitPriorityConverter();
final _habitTypeConverter = HabitTypeConverter();
