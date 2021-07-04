import 'package:buy_now_demo/shared/app_cubit/cubit.dart';
import 'package:buy_now_demo/shared/network/local/cache_helper.dart';
import 'package:buy_now_demo/shared/network/remote/dio_helper.dart';
import 'package:buy_now_demo/shared/network/repository.dart';
import 'package:buy_now_demo/shared/user_cubit/cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt di = GetIt.I..allowReassignment = true;

Future init() async {
  final sp = await SharedPreferences.getInstance();

  di.registerLazySingleton<SharedPreferences>(
    () => sp,
  );

  di.registerLazySingleton<CacheHelper>(
    () => CacheImplementation(
      di<SharedPreferences>(),
    ),
  );

  di.registerLazySingleton<DioHelper>(
    () => DioImplementation(),
  );
  di.registerLazySingleton<Repository>(
    () => RepositoryImplementation(
      di<DioHelper>(),
      di<CacheHelper>(),
    ),
  );

  di.registerFactory(
    () => AppCubit(
      di<Repository>(),
    ),
  );

  di.registerFactory(
    () => UserCubit(
      di<Repository>(),
    ),
  );

  // di.registerFactory<AppCubit>(
  //   () => AppCubit(),
  // );

  // di.registerLazySingleton<DioHelper>(
  //       () => DioImplementation(),
  // );
  //
  // di.registerLazySingleton<Repository>(
  //       () => RepoImplementation(
  //     dioHelper: di<DioHelper>(),
  //     cacheHelper:di<CacheHelper>(),
  //   ),
  // );
  //

  // di.registerFactory<LoginCubit>(
  //       () => LoginCubit(
  //     di<Repository>(),
  //   ),
  // );
}
