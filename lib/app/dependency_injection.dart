import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:miseo/app/app_prefs.dart';
import 'package:miseo/data/data_source/remote_data_source.dart';
import 'package:miseo/data/network/app_api.dart';
import 'package:miseo/data/network/dio_factory.dart';
import 'package:miseo/data/network/network_info.dart';
import 'package:miseo/data/repository/repository_impl.dart';
import 'package:miseo/domain/repository/repository.dart';
import 'package:miseo/domain/usecase/login_usecase.dart';
import 'package:miseo/presentation/login/login_viewmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  //shared Preferences instance
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app Preferences instance
  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  //network info instance
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()));

  // dio factory instance
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  // app service client instance
  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  //remote data source instance
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImplementer(instance()));

  //repository instance
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}
