import 'dart:io';
import 'package:flutter_demo/core/models/contact.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter_demo/core/models/user.dart';

class DatabaseHelper {
  static const _databaseName = 'ContactData.db';
  static const _databaseVersion = 1;

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  Database _database;
  Future<Database> get database async {
    // await _delteDatabase();
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _delteDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDocDir.path, _databaseName);
    await deleteDatabase(dbPath);
  }

  _initDatabase() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = join(appDocDir.path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion, onCreate: _create);
  }

  _onCreateDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${User.tblUser}(
        ${User.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${User.colEmail} TEXT NOT NULL,
        ${User.colPassword} TEXT NOT NULL
      )
      ''');
  }

  Future _create(Database db, int version) async {
    await db.execute("""
            CREATE TABLE ${'email'} (
              email_id INTEGER PRIMARY KEY AUTOINCREMENT, 
              contact_id INTEGER NOT NULL,
              email TEXT NOT NULL,
              FOREIGN KEY (contact_id) REFERENCES ${'contact'} (${'contact_id'}) 
                ON DELETE NO ACTION ON UPDATE NO ACTION
            )""");
    await db.execute("""
    CREATE TABLE ${'phone'} (
      phone_id INTEGER PRIMARY KEY AUTOINCREMENT, 
      contact_id INTEGER NOT NULL,
      phone TEXT NOT NULL,
      FOREIGN KEY (contact_id) REFERENCES ${'contact'} (${'contact_id'}) 
                ON DELETE NO ACTION ON UPDATE NO ACTION
    )""");
    await db.execute("""
            CREATE TABLE ${'contact'} (
              contact_id INTEGER PRIMARY KEY AUTOINCREMENT, 
              user_id INTEGER NOT NULL,
              address TEXT NOT NULL,
              name TEXT NOT NULL,
              FOREIGN KEY (user_id) REFERENCES ${User.tblUser} (${User.colId}) 
                ON DELETE NO ACTION ON UPDATE NO ACTION
            )""");

    await db.execute("""
            CREATE TABLE ${User.tblUser}(
        ${User.colId} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${User.colEmail} TEXT NOT NULL,
        ${User.colPassword} TEXT NOT NULL
      )""");
  }
}
