
import 'package:myactivity_project/models/Login%20Offline/model_log_login_offline.dart';
import 'package:myactivity_project/models/model_log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelperLoginOffline {
  static final DbHelperLoginOffline _instance = DbHelperLoginOffline._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tb_active';
  final String columnId = 'id_act';
  final String columnDeskripsi = 'deskripsi';
  final String columnDatetime = 'datetime';

  DbHelperLoginOffline._internal();
  factory DbHelperLoginOffline() => _instance;

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
    String path = join(databasePath, 'active.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$columnDeskripsi TEXT,"
        "$columnDatetime TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveActivityy(LoginOffline activityy) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, activityy.toMap());
  }

  //read database
  Future<List?> getAllFormat() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnDeskripsi,
      columnDatetime,
    ]);

    return result.toList();
  }

  //hapus database
  Future<int?> deleteActivityy(int id_act) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id_act]);
  }


}
