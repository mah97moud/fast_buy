import 'package:buy_now_demo/shared/app_cubit/cubit.dart';
import 'package:buy_now_demo/shared/di/di.dart';
import 'package:buy_now_demo/shared/language/app_language_model.dart';
import 'package:buy_now_demo/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

AppLanguageModel appLang(context) => AppCubit.get(context).languageModel;

String appLanguage = '';
String userToken = '';
TextDirection appDirection;

Future<String> get getAppLanguage async {
  return await di<CacheHelper>().get('appLangCode');
}

Future<String> get getUserToken async {
  return await di<CacheHelper>().get('userToken');
}

Future<bool> setAppLanguageToShared({@required String code}) async {
  appLanguage = code;
  return await di<CacheHelper>().put('appLangCode', code);
}

Future<String> getTranslationFile({@required appLanguage}) async {
  return await rootBundle
      .loadString('assets/translation/${appLanguage ?? 'en'}.json');
}
