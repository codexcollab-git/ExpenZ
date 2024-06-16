// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppDatabase.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
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

  SmsDao? _smsDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `smsTable` (`smsId` INTEGER, `smsSender` TEXT, `smsBody` TEXT, `transactionAmount` REAL, `merchant` TEXT, `referenceNo` TEXT, `bankName` TEXT, `accountTypeEnum` TEXT, `accountNo` TEXT, `accountName` TEXT, `transactionTypeEnum` TEXT, `transactionKeyword` TEXT, `transactionModeEnum` TEXT, `amountAvailable` TEXT, `amountOutstanding` TEXT, `hide` INTEGER NOT NULL, `smsDateTime` INTEGER, PRIMARY KEY (`smsId`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SmsDao get smsDao {
    return _smsDaoInstance ??= _$SmsDao(database, changeListener);
  }
}

class _$SmsDao extends SmsDao {
  _$SmsDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _smsEntityInsertionAdapter = InsertionAdapter(
            database,
            'smsTable',
            (SmsEntity item) => <String, Object?>{
                  'smsId': item.smsId,
                  'smsSender': item.smsSender,
                  'smsBody': item.smsBody,
                  'transactionAmount': item.transactionAmount,
                  'merchant': item.merchant,
                  'referenceNo': item.referenceNo,
                  'bankName': item.bankName,
                  'accountTypeEnum': item.accountTypeEnum,
                  'accountNo': item.accountNo,
                  'accountName': item.accountName,
                  'transactionTypeEnum': item.transactionTypeEnum,
                  'transactionKeyword': item.transactionKeyword,
                  'transactionModeEnum': item.transactionModeEnum,
                  'amountAvailable': item.amountAvailable,
                  'amountOutstanding': item.amountOutstanding,
                  'hide': item.hide,
                  'smsDateTime': item.smsDateTime
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SmsEntity> _smsEntityInsertionAdapter;

  @override
  Future<List<SmsEntity>> getAllSms() async {
    return _queryAdapter.queryList('SELECT * FROM smsTable',
        mapper: (Map<String, Object?> row) => SmsEntity(
            smsId: row['smsId'] as int?,
            smsSender: row['smsSender'] as String?,
            smsBody: row['smsBody'] as String?,
            transactionAmount: row['transactionAmount'] as double?,
            merchant: row['merchant'] as String?,
            referenceNo: row['referenceNo'] as String?,
            bankName: row['bankName'] as String?,
            accountTypeEnum: row['accountTypeEnum'] as String?,
            accountNo: row['accountNo'] as String?,
            accountName: row['accountName'] as String?,
            transactionTypeEnum: row['transactionTypeEnum'] as String?,
            transactionKeyword: row['transactionKeyword'] as String?,
            transactionModeEnum: row['transactionModeEnum'] as String?,
            amountAvailable: row['amountAvailable'] as String?,
            amountOutstanding: row['amountOutstanding'] as String?,
            hide: row['hide'] as int,
            smsDateTime: row['smsDateTime'] as int?));
  }

  @override
  Future<void> hideSms(int id) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE smsTable SET hide = 1 where smsId= ?1',
        arguments: [id]);
  }

  @override
  Future<int?> getLastSmsTimeStamp() async {
    return _queryAdapter.query('SELECT max(smsDateTime) from smsTable',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> insertSms(SmsEntity sms) async {
    await _smsEntityInsertionAdapter.insert(sms, OnConflictStrategy.ignore);
  }
}
