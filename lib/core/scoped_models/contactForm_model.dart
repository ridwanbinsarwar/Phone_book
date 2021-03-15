import 'package:flutter_demo/core/models/contact.dart';
import 'package:flutter_demo/core/scoped_models/home_model.dart';
import 'package:flutter_demo/service_locator.dart';
import 'package:flutter_demo/utils/database_helper.dart';
import 'base_model.dart';

class ContactFormModel extends BaseModel {
  Contact contact = new Contact();
  Email email = new Email();
  Phone phone = new Phone();
  DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  void setEmail(value) {
    email.email = value;
    notifyListeners();
  }

  String getEmail() {
    if (email.email != null) {
      return email.email;
    } else
      return 'empty';
  }

  void setName(value) {
    contact.name = value;
    notifyListeners();
  }

  // String getEmail() {
  //   if (email.email != null) {
  //     return email.email;
  //   } else
  //     return 'empty';
  // }

  void setPhone(value) {
    phone.phone = value;
    notifyListeners();
  }

  String getPhone() {
    if (phone.phone != null) {
      return phone.phone;
    } else
      return 'empty';
  }

  void setAddress(value) {
    contact.address = value;
    notifyListeners();
  }

  String getAddress() {
    if (contact.address != null) {
      return contact.address;
    } else
      return 'empty';
  }

  Future<int> addContact(id) async {
    contact.user_id = id;
    await _databaseHelper.fetchContactsByUser(id);

    int res = await _databaseHelper.insertContact(contact, email, phone);
    if (res != -1) {
      var myAppModel = locator<HomeModel>();
      myAppModel.addContact(contact);
    }
    return res;
  }
}
