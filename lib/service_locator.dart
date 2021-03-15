import 'package:flutter_demo/core/scoped_models/contactForm_model.dart';
import 'package:flutter_demo/core/scoped_models/login_model.dart';
import 'package:get_it/get_it.dart';
import 'core/scoped_models/registration_model.dart';
import 'core/scoped_models/home_model.dart';
import 'core/services/storage_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton<StorageService>(() => StorageService());

  // Register models
  locator.registerFactory<HomeModel>(() => HomeModel());
  locator.registerFactory<RegistraionModel>(() => RegistraionModel());
  locator.registerFactory<LoginModel>(() => LoginModel());
  locator.registerFactory<ContactFormModel>(() => ContactFormModel());
}
