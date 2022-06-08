
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:synchronized/synchronized.dart';
import 'package:todo_acf_v2/app/core/database/sqlite_migration_factory.dart';

class SqliteConnectionFactory{

  static const _VERSION = 1;
  static const _DATA_BASE_NAME = "TODO_LIST_PROVIDER";


  static SqliteConnectionFactory? _instance;

  Database? _db;
  final _lock = Lock();

  SqliteConnectionFactory._();

  factory SqliteConnectionFactory(){
    _instance ??= SqliteConnectionFactory._();
    return _instance!;
  }


  Future<Database> openConnection() async{
    var databasePath = await getDatabasesPath();
    var databasePathFinal = join(databasePath, _DATA_BASE_NAME);
    if(_db == null){
      _lock.synchronized(() async {
        _db ??= await openDatabase(
            databasePathFinal,
            version: _VERSION,
            onConfigure: _onConfigure,
            onCreate: _onCreate,
            onUpgrade: _onUpgrade,
            onDowngrade: _onDownGrade
        );
      });
    }
    return _db!;
  }

  void closeConncetion(){
    _db?.close();
    _db = null;
  }

  Future<void> _onConfigure(Database db) async{
    await db.execute("PRAGMA foreign_keys = ON");
  }

  Future<void> _onCreate(Database db, int version) async{
    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getCreateMigration();
    for (var migration in migrations){
      migration.create(batch);
    }

    batch.commit();
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int version) async{
    final batch = db.batch();

    final migrations = SqliteMigrationFactory().getUpgradeMigration(oldVersion);
    for (var migration in migrations){
      migration.update(batch);
    }

    batch.commit();

  }

  Future<void> _onDownGrade(Database db, int oldVersion, int version) async{

  }

}