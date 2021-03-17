import 'package:flutter_demo/core/models/contact.dart';
import 'package:flutter_demo/core/services/database_query_service.dart';
import 'package:flutter_demo/service_locator.dart';
import 'base_model.dart';

class ContactProfileModel extends BaseModel {
  BaseContact user = new BaseContact();
  DatabaseQueryService _databaseHelper = locator<DatabaseQueryService>();

  Future<BaseContact> getContactInformation(int id) async {
    List<Map> data = await _databaseHelper.fetchUserInformation(id);
    user = BaseContact.fromMap(data[0]);
    return user;
  }

  getContact(int id) {
    user.contact.address = id.toString();
    return user;
  }
}
