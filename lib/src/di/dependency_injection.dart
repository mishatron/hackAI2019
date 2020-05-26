import 'package:get_it/get_it.dart';
import 'package:hackai/router/navigation_service.dart';
import 'package:hackai/src/core/api/dio_manager.dart';
import 'package:hackai/src/data/repositories/auth_repository.dart';
import 'package:hackai/src/data/repositories/auth_repository_impl.dart';
import 'package:hackai/src/data/sources/remote/remote_datasource.dart';
import 'package:hackai/src/data/sources/remote/remote_datasource_impl.dart';

enum Flavor { MOCK, DEV, PROD }

GetIt injector = GetIt.instance;

/// Simple DI
class InjectorDI {
  static final InjectorDI singleton = InjectorDI._internal();
  Flavor flavor;

  InjectorDI._internal();

  /// init configuration
  void configure(Flavor flavor) {
    assert(flavor != null);
    flavor = flavor;

    if (flavor == Flavor.DEV) {
      DioManager.BASE_URL = "http://opendatavinnytsia.azurewebsites.net/api/";
    } else if (flavor == Flavor.PROD) {
      DioManager.BASE_URL = "http://opendatavinnytsia.azurewebsites.net/api/";
    }

    injector.registerLazySingleton(() => NavigationService());

    injector.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

    injector
        .registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());

    DioManager.configure();
  }

  factory InjectorDI() {
    return singleton;
  }
}
