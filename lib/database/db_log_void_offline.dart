import 'package:myactivity_project/models/Login%20Offline/model_log_void_offline.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelperVoidOffline {
  static final DbHelperVoidOffline _instance = DbHelperVoidOffline._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tb_void';
  final String columnId = 'id_act';
  final String columnIdGenerate = 'idGenerate';
  final String columnDate = 'date';

  DbHelperVoidOffline._internal();
  factory DbHelperVoidOffline() => _instance;

  //cek apakah database ada
  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'void.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$columnIdGenerate TEXT,"
        "$columnDate TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveActivityVoidOffline(VoidOffline activityy) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, activityy.toMap());
  }

  //read database
  Future<List?> getAllFormatVoidOffline() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnIdGenerate,
      columnDate,
    ]);

    return result.toList();
  }

  //hapus database
  Future<int?> deleteVoidOffline(int id_act) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id_act]);
  }

    Future<int?> deleteAll() async {
    var dbClient = await _db;
    return await dbClient!
        .rawDelete("DELETE FROM $tableName");
  }
}