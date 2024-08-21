
import 'package:myactivity_project/models/Login%20Offline/model_log_login_offline.dart';
import 'package:myactivity_project/models/StockOpname/model_saveData.dart';
import 'package:myactivity_project/models/StockOpname/model_so.dart';
import 'package:myactivity_project/models/model_log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DbSoSaveData {
  static final DbSoSaveData _instance = DbSoSaveData._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tb_save_data';
  final String columnId = 'id';
  final String columnPos = 'pos';
  final String columnLocation = 'location';
  final String columnTanggal = 'tanggal';
  final String columnData = 'data';

  DbSoSaveData._internal();
  factory DbSoSaveData() => _instance;

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
    String path = join(databasePath, 'saveData.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$columnPos TEXT,"
        "$columnLocation TEXT,"
        "$columnTanggal TEXT,"
        "$columnData TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> save(SoSaveDataModel so) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, so.toMap());
  }

  //read database
  Future<List?> getAllFormat() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnPos,
      columnLocation,
      columnTanggal,
      columnData,
    ]);
    return result.toList();
  }

  //hapus database
  Future<int?> delete(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int?> deleteAll() async {
    var dbClient = await _db;
    return await dbClient!
        .rawDelete("DELETE FROM $tableName");
  }


}
