import 'package:get_it/get_it.dart';

import 'core/scoped_models/auth_model.dart';
import 'core/scoped_models/error_model.dart';
import 'core/scoped_models/home_model.dart';
import 'core/scoped_models/success_model.dart';
import 'core/services/storage_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register services
  locator.registerLazySingleton<StorageService>(() => StorageService());

  // Register models
  locator.registerFactory<HomeModel>(() => HomeModel());
  locator.registerFactory<ErrorModel>(() => ErrorModel());
  locator.registerFactory<SuccessModel>(() => SuccessModel());
  locator.registerFactory<AuthnModel>(() => AuthnModel());
}
