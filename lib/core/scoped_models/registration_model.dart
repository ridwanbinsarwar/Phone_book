import 'package:flutter_demo/core/models/user.dart';
import 'package:flutter_demo/utils/database_helper.dart';
import 'base_model.dart';

class RegistraionModel extends BaseModel {
  User user = new User();
  List<User> users;
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  void setEmail(value) {
    user.email = value;
    notifyListeners();
  }

  String getEmail() {
    if (user.email != null) {
      return user.email;
    } else
      return 'empty';
  }

  String getPassword() {
    if (user.password != null) {
      return user.password;
    } else
      return 'empty';
  }

  void setPassword(value) {
    user.password = value;
    notifyListeners();
  }

  Future<bool> insertUser() async {
    if (await _databaseHelper.checkIfEmailExists(user.email) == false) {
      await _databaseHelper.insertUser(user);
      return true;
    }
    return false;
  }

  void getUsers() async {
    List<User> x = await _databaseHelper.fetchContacts();
    print(x[0].email);
    users = x;
  }

  void getUserList() {
    print(users);
  }
}
