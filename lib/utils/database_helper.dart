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
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
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

  Future<int> insertUser(User user) async {
    Database db = await database;
    return await db.insert(User.tblUser, user.toMap());
  }

  insertContact(Contact contact, Email email, Phone phone) async {
    Database db = await database;
    int contact_id = await db.insert('contact', contact.toMap());
    print(contact_id);
    email.contact_id = contact_id;
    phone.contact_id = contact_id;
    await db.insert('email', email.toMap());
    await db.insert('phone', phone.toMap());
  }

  fetchContactsByUser(int id) async {
    Database db = await database;
    List<Map> list = await db.rawQuery(
        // ignore: unnecessary_brace_in_string_interps
        'SELECT contact.address, phone.phone, email.email FROM user INNER JOIN contact ON user.user_id=contact.user_id INNER JOIN phone ON contact.contact_id=phone.contact_id INNER JOIN email ON contact.contact_id=email.contact_id WHERE user.user_id = ${id};');
    print(list);
  }

  Future<List<User>> fetchContacts() async {
    Database db = await database;
    List<Map> contacts = await db.query(User.tblUser);
    return contacts.length == 0
        ? []
        : contacts.map((x) => User.fromMap(x)).toList();
  }

  Future<int> isRegistered(String email, String password) async {
    var dbContact = await database;
    List<Map> maps = await dbContact.query(User.tblUser,
        columns: [User.colId],
        where: '${User.colEmail} = ? and ${User.colPassword} = ?',
        whereArgs: [email, password]);
    if (maps.isNotEmpty) {
      return maps[0].entries.first.value;
    } else {
      return -1;
    }
  }

  Future<bool> checkIfEmailExists(String email) async {
    Database db = await database;
    List<dynamic> whereargs = [email];
    List<Map> result = await db.query(User.tblUser,
        where: '${User.colEmail} = ?', whereArgs: whereargs);
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
