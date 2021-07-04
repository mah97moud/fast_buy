import 'package:buy_now_demo/models/categories/categories_model.dart';
import 'package:buy_now_demo/models/home/home_model.dart';
import 'package:flutter/material.dart';

abstract class AppStates {}

class AppInitState extends AppStates {}

class AppLoadingState extends AppStates {}

class AppLoadingCartDataState extends AppStates {}

class AppLoadingCategoriesState extends AppStates {}

class AppLoadingFavState extends AppStates {
  final int id;

  AppLoadingFavState({@required this.id});
}

class AppSuccessFavState extends AppStates {}

class AppSuccessCartDataState extends AppStates {}

class AppErrorFavState extends AppStates {
  final String error;

  AppErrorFavState(this.error);
}

class AppErrorCartDataState extends AppStates {
  final String error;

  AppErrorCartDataState(this.error);
}

class AppLoadingCartState extends AppStates {}

class AppSuccessCartState extends AppStates {}

class AppErrorCartState extends AppStates {
  final String error;

  AppErrorCartState(this.error);
}

class AppSelectLanguageState extends AppStates {}

class AppSetLanguageState extends AppStates {}

class AppSetDirectionState extends AppStates {}

class BottomIndexState extends AppStates {}

class AppHomeSuccessState extends AppStates {
  final HomeModel homeModel;

  AppHomeSuccessState(this.homeModel);
}

class AppCategoriesSuccessState extends AppStates {
  final CategoriesModel categoriesModel;

  AppCategoriesSuccessState(this.categoriesModel);
}

class AppErrorState extends AppStates {
  final String error;

  AppErrorState(this.error) {
    print(error.toString());
  }
}

class AppCategoriesErrorState extends AppStates {
  final String error;

  AppCategoriesErrorState(this.error) {
    print(error.toString());
  }
}

class AppUpdateCartLoading extends AppStates {}

class AppUpdateCartError extends AppStates {
  final String error;

  AppUpdateCartError(this.error);
}

class CategoryDetailsLoadingState extends AppStates {}

class CategoryDetailsSuccessState extends AppStates {}

class CategoryDetailsErrorState extends AppStates {
  final String error;

  CategoryDetailsErrorState(this.error);
}

class CartDeleteLoadingState extends AppStates {}

class CartDeleteSuccessState extends AppStates {}

class CartDeleteErrorState extends AppStates {
  final String error;

  CartDeleteErrorState(this.error);
}
