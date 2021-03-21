import 'dart:typed_data';

import 'package:flutter_demo/core/models/contact.dart';
import 'package:flutter_demo/core/scoped_models/home_model.dart';
import 'package:flutter_demo/core/services/database_query_service.dart';
import 'package:flutter_demo/service_locator.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactFormModel extends Model {
  Contact contact = new Contact();
  Email email = new Email();
  Phone phone = new Phone();
  DatabaseQueryService _databaseHelper = locator<DatabaseQueryService>();

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

  void setPicture(value) {
    contact.picture = value;
    notifyListeners();
  }

  Uint8List getPicture() {
    return contact.picture;
  }

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
      contact.contact_id = res;
      myAppModel.addContact(contact);
    }
    return res;
  }
}
