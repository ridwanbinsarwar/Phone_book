import 'package:flutter_demo/core/scoped_models/home_model.dart';
import 'package:flutter_demo/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  String key = 'userID';
  Future<int> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int user = (prefs.getInt(key) ?? -1);
    return user;
  }

  void removeSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
    var myAppModel = locator<HomeModel>();
    myAppModel.clearContact();
    return;
  }
}
