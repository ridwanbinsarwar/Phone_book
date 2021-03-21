import 'package:flutter_demo/core/models/contact.dart';
import 'package:flutter_demo/core/services/database_query_service.dart';
import 'package:flutter_demo/service_locator.dart';
import 'package:scoped_model/scoped_model.dart';

class ContactProfileModel extends Model {
  BaseContact user = new BaseContact();
  DatabaseQueryService _databaseHelper = locator<DatabaseQueryService>();
  Email email = new Email();
  Phone phone = new Phone();

  setPhone(value) {
    this.phone.phone = value;
  }

  setEmail(value) {
    this.email.email = value;
  }

  Future<BaseContact> getContactInformation(int id) async {
    List<Map> data = await _databaseHelper.fetchUserInformation(id);
    this.user = BaseContact.fromMap(data[0]);
    return this.user;
  }

  Future<Phone> addPhone(int contactId) async {
    Phone tempPhone = new Phone();
    tempPhone.contact_id = contactId;
    tempPhone.phone = phone.phone;
    var res;
    try {
      res = await _databaseHelper.insertPhone(tempPhone);
      tempPhone.phone_id = res;
    } catch (e) {
      print('phone update error');
    }
    return tempPhone;
  }

  Future<int> updateEmail(int emailId) async {
    var res;
    try {
      res = await _databaseHelper.updateEmail(id: emailId, email: email.email);
    } catch (e) {
      print('Email update error');
    }
    return res;
  }

  Future<int> deleteEmail(int emailId) async {
    var res;
    try {
      res = await _databaseHelper.deleteEmail(emailId);
    } catch (e) {
      print('Email delete error');
    }
    return res;
  }

  Future<int> deltePhone(int phoneId) async {
    var res;
    try {
      res = await _databaseHelper.deletePhone(phoneId);
    } catch (e) {
      print('Phone delete error');
    }
    return res;
  }

  Future<int> updatePhone(int phoneId) async {
    var res;
    try {
      res = await _databaseHelper.updatePhone(id: phoneId, phone: phone.phone);
    } catch (e) {
      print('phone update error');
    }
    return res;
  }

  Future<Email> addEmail(int contactId) async {
    Email tempEmail = new Email();
    tempEmail.email = email.email;
    tempEmail.contact_id = contactId;
    var res = await _databaseHelper.insertEmail(tempEmail);
    tempEmail.email_id = res;
    return tempEmail;
  }

  getContact(int id) {
    user.contact.address = id.toString();
    return user;
  }
}
