import 'package:flutter_demo/core/scoped_models/contactForm_model.dart';
import 'package:flutter_demo/core/scoped_models/home_model.dart';
import 'package:flutter_demo/core/scoped_models/login_model.dart';
import 'package:flutter_demo/core/scoped_models/registration_model.dart';
import 'package:flutter_demo/core/services/storage_service.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton<StorageService>(() => StorageService());

  // Register models
  locator.registerSingleton<HomeModel>(HomeModel());
  locator.registerFactory<RegistraionModel>(() => RegistraionModel());
  locator.registerFactory<LoginModel>(() => LoginModel());
  locator.registerFactory<ContactFormModel>(() => ContactFormModel());
}
