import 'package:flutter_demo/core/models/contact.dart';
import 'package:flutter_demo/core/scoped_models/base_model.dart';
import 'package:flutter_demo/core/services/database_query_service.dart';
import 'package:flutter_demo/core/services/storage_service.dart';
import 'package:flutter_demo/enums/view_state.dart';
import 'package:flutter_demo/service_locator.dart';

class HomeModel extends BaseModel {
  StorageService storageService = locator<StorageService>();
  DatabaseQueryService _databaseHelper = locator<DatabaseQueryService>();

  String title = "";
  bool loaded = false;

  List<BaseContact> contacts = [];

  void getContacts(Future<int> id) async {
    int userId = await id;
    List<Map> data = await _databaseHelper.fetchContactsByUser(userId);
    for (var contact in data) {
      contacts.add(BaseContact.contact(new Contact.fromMap(contact)));
    }
    loaded = true;
    notifyListeners();
  }

  void addContact(Contact contact) {
    contacts.add(BaseContact.contact(contact));
    notifyListeners();
  }

  Future<int> deleteContact(int id) async {
    return await _databaseHelper.deleteContact(id);
  }

  void setTitle(String value) {
    title = value;
  }

  String getTitle() {
    return title;
  }
}
