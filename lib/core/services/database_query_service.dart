import 'package:flutter_demo/core/models/contact.dart';
import 'package:flutter_demo/core/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_demo/utils/database_helper.dart';

class DatabaseQueryService {
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<int> insertUser(User user) async {
    Database db = await _databaseHelper.database;
    return await db.insert(User.tblUser, user.toMap());
  }

  Future<int> insertContact(Contact contact, Email email, Phone phone) async {
    Database db = await _databaseHelper.database;
    int contact_id = await db.insert('contact', contact.toMap());
    email.contact_id = contact_id;
    phone.contact_id = contact_id;
    await db.insert('email', email.toMap());
    await db.insert('phone', phone.toMap());
    return contact_id;
  }

  Future<int> insertPhone(Phone phone) async {
    Database db = await _databaseHelper.database;
    return await db.insert('phone', phone.toMap());
  }

  Future<int> insertEmail(Email email) async {
    Database db = await _databaseHelper.database;
    return await db.insert('email', email.toMap());
  }

  Future<int> updateEmail({int id, String email}) async {
    Database db = await _databaseHelper.database;
    return await db.rawUpdate('UPDATE email SET email = ? WHERE email_id = ?', [
      email,
      id,
    ]);
  }

  Future<int> updatePhone({int id, String phone}) async {
    Database db = await _databaseHelper.database;
    return await db.rawUpdate('UPDATE phone SET phone = ? WHERE phone_id = ?', [
      phone,
      id,
    ]);
  }

  Future<int> deletePhone(int id) async {
    Database db = await _databaseHelper.database;
    return await db.rawDelete('DELETE FROM phone WHERE phone_id = ?', [id]);
  }

  Future<int> deleteEmail(int id) async {
    Database db = await _databaseHelper.database;
    return await db.rawDelete('DELETE FROM email WHERE email_id = ?', [id]);
  }

  Future<List<Map>> fetchUserInformation(int id) async {
    Database db = await _databaseHelper.database;
    List<Map> list = await db.rawQuery(
        // ignore: unnecessary_brace_in_string_interps
        'SELECT contact.contact_id, contact.name, contact.address, GROUP_CONCAT(distinct (phone.phone_id ||"-"|| phone.phone)) as phones, GROUP_CONCAT(distinct (email.email_id ||"-"|| email.email)) as emails FROM contact INNER JOIN phone ON contact.contact_id=phone.contact_id INNER JOIN email ON contact.contact_id=email.contact_id  WHERE contact.contact_id = ${id} GROUP BY contact.contact_id');

    return list;
  }

  Future<List<Map>> fetchContactsByUser(int id) async {
    print(id);
    Database db = await _databaseHelper.database;
    List<Map> list = await db.rawQuery(
        // ignore: unnecessary_brace_in_string_interps
        'SELECT * FROM user INNER JOIN contact ON user.user_id=contact.user_id WHERE user.user_id = ${id};');
    print(list);
    return list;
  }

  Future<List<User>> fetchContacts() async {
    Database db = await _databaseHelper.database;
    List<Map> contacts = await db.query(User.tblUser);
    return contacts.length == 0
        ? []
        : contacts.map((x) => User.fromMap(x)).toList();
  }

  Future<int> isRegistered(String email, String password) async {
    var dbContact = await _databaseHelper.database;
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
    Database db = await _databaseHelper.database;
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
