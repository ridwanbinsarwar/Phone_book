import 'package:flutter_demo/core/services/storage_service.dart';
import 'package:flutter_demo/enums/view_state.dart';
import 'package:flutter_demo/service_locator.dart';

import 'base_model.dart';

class HomeModel extends BaseModel {
  StorageService storageService = locator<StorageService>();
  String title = "HomeModel";

  Future<bool> saveData() async {
    setState(ViewState.Busy);
    setTitle("Saving Data");
    await storageService.saveData();
    setTitle("Data Saved");
    setState(ViewState.Retrieved);

    return true;
  }

  void setTitle(String value) {
    title = value;
  }
}
