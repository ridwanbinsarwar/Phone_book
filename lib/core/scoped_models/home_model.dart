import 'package:flutter_demo/core/models/contact.dart';
import 'package:flutter_demo/core/scoped_models/base_model.dart';
import 'package:flutter_demo/core/services/storage_service.dart';
import 'package:flutter_demo/enums/view_state.dart';
import 'package:flutter_demo/service_locator.dart';
import 'package:flutter_demo/utils/database_helper.dart';

class HomeModel extends BaseModel {
  StorageService storageService = locator<StorageService>();
  String title = "";
  bool loaded = false;

  List<BaseContact> contacts = [];
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

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

  // Future<bool> saveData() async {
  //   setState(ViewState.Busy);
  //   setTitle("Saving Data");
  //   await storageService.saveData();
  //   setTitle("Data Saved");
  //   setState(ViewState.Retrieved);

  //   return true;
  // }

  void setTitle(String value) {
    title = value;
  }

  String getTitle() {
    return title;
  }
}

class BaseContact {
  Contact contact = new Contact();
  List<Email> emails = [];
  List<Phone> phones = [];
  BaseContact.contact(this.contact);
}
