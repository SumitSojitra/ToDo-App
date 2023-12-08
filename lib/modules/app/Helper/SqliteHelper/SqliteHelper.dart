import 'dart:developer';

import 'package:my_todo/modules/app/views/HomeScreen/model/model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteHelper {
  SqliteHelper._();

  static final SqliteHelper sqliteHelper = SqliteHelper._();

  static Database? db;

  Future initDb() async {
    String dbPath = await getDatabasesPath();
    String path = await join(dbPath, "task.db");

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE Tasks(task TEXT,date TEXT,time TEXT);");
      },
    );
  }

  Future<int?> addTasks({required TaskModel model}) async {
    await initDb();
    String qry = "INSERT INTO Tasks VALUES(?,?,?)";
    List arg = [model.task, model.date, model.time];
    int? res = await db?.rawInsert(qry, arg);
    log("=======================");
    return res;
  }

  Future<List<TaskModel>> fetchTasks() async {
    await initDb();
    String qry = "SELECT * FROM Tasks;";
    List<Map<String, Object?>>? res = await db?.rawQuery(qry);

    List<TaskModel> allData =
        await res!.map((e) => TaskModel.fromMap(data: e)).toList();
    return allData;
  }

  Future<int?> deleteTask({required String task}) async {
    await initDb();
    String qry = "DELETE FROM Tasks WHERE task=?;";
    List arg = [task];
    int? res = await db!.rawDelete(qry, arg);
    return res;
  }
}
