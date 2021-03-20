import 'package:flutter_demo/core/scoped_models/contactForm_model.dart';
import 'package:flutter_demo/core/scoped_models/contact_profile_model.dart';
import 'package:flutter_demo/core/scoped_models/home_model.dart';
import 'package:flutter_demo/core/scoped_models/login_model.dart';
import 'package:flutter_demo/core/scoped_models/registration_model.dart';
import 'package:flutter_demo/core/services/database_query_service.dart';
import 'package:flutter_demo/core/services/shared_pred_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton<SharedPrefService>(() => SharedPrefService());
  locator.registerLazySingleton<DatabaseQueryService>(
      () => DatabaseQueryService());

  // Register models
  locator.registerSingleton<HomeModel>(HomeModel());
  locator.registerFactory<ContactProfileModel>(() => ContactProfileModel());
  locator.registerFactory<RegistraionModel>(() => RegistraionModel());
  locator.registerFactory<LoginModel>(() => LoginModel());
  locator.registerFactory<ContactFormModel>(() => ContactFormModel());
}
