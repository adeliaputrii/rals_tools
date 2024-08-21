
import 'package:myactivity_project/models/Login%20Offline/model_log_login_offline.dart';
import 'package:myactivity_project/models/StockOpname/model_so.dart';
import 'package:myactivity_project/models/model_log.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelperStockOpname {
  static final DbHelperStockOpname _instance = DbHelperStockOpname._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tb_so';
  final String columnId = 'id';
  final String columnSku = 'sku';
  final String columnQuantity = 'quantity';

  DbHelperStockOpname._internal();
  factory DbHelperStockOpname() => _instance;

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
    String path = join(databasePath, 'so.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY AUTOINCREMENT, "
        "$columnSku TEXT,"
        "$columnQuantity TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> save(StockOpnameModel so) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, so.toMap());
  }

  //read database
  Future<List?> getAllFormat() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName, columns: [
      columnId,
      columnSku,
      columnQuantity,
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
