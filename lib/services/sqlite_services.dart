import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const dbName = "mydatabase.db";
  static const dbVersion = 1;
  static const dbTable = "myTable";
   static const columId = "id";
    static const columname = "  name";

    


  // Future<Database> initializeDB() async {
  //   String path = await getDatabasesPath();

  //   return openDatabase(
  //     join(path, 'database.db'),
  //     onCreate: (database, version) async {
  //       await database.execute(
  //         "CREATE TABLE Notes(id INTEGER PRIMARY KEY AUTOINCREMENT,description TEXT NOT NULL)",
  //       );
  //     },
  //     version: 1,
  //   );
  // }
}
