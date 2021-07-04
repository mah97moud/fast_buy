import 'dart:convert';

import 'package:buy_now_demo/layouts/cart/cart_layout.dart';
import 'package:buy_now_demo/models/cart/add_or_remove_cart_model.dart';
import 'package:buy_now_demo/models/cart/cart_model.dart';
import 'package:buy_now_demo/models/categories/categories_details_model.dart';
import 'package:buy_now_demo/models/categories/categories_model.dart';
import 'package:buy_now_demo/models/favourite/add_or_remove_model.dart';
import 'package:buy_now_demo/models/home/home_model.dart';
import 'package:buy_now_demo/modules/categories/categories_screen.dart';
import 'package:buy_now_demo/modules/category_details/category_details.dart';
import 'package:buy_now_demo/modules/home/home_screen.dart';
import 'package:buy_now_demo/modules/settings/settings_screen.dart';
import 'package:buy_now_demo/shared/app_cubit/states.dart';
import 'package:buy_now_demo/shared/components/constants.dart';
import 'package:buy_now_demo/shared/components/widgets.dart';
import 'package:buy_now_demo/shared/language/app_language_model.dart';
import 'package:buy_now_demo/shared/network/repository.dart';
import 'package:buy_now_demo/shared/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  final Repository _repository;
  AppCubit(this._repository) : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<bool> selectedLanguage = [
    false,
    false,
  ];
  TextDirection textDirection = TextDirection.rtl;
  bool isArabic = false;
  bool isCenter = false;
  int selectedLanguageIndex;

  List<Widget> bottomWidgets = [
    HomeScreen(),
    CartLayout(),
    CategoriesScreen(),
    SettingsScreen(),
  ];
  // List<Widget> titleWidgets = [
  //   Text(
  //     appLang(context).discover,
  //     style: TextStyle(
  //       color: kAppRedColor,
  //     ),
  //   ),
  //   Text(
  //     appLang(context).shoppingCart,
  //     style: TextStyle(
  //       color: kAppRedColor,
  //     ),
  //   ),
  //   Text(
  //     appLang(context).category,
  //     style: TextStyle(
  //       color: kAppRedColor,
  //     ),
  //   ),
  //   Text(
  //     appLang(context).settings,
  //     style: TextStyle(
  //       color: kAppRedColor,
  //     ),
  //   ),
  // ];

  Widget titleWidget({@required int index, @required BuildContext context}) {
    List<Widget> titleWidgets = [
      Text(
        appLang(context).discover,
        style: TextStyle(
          color: kAppRedColor,
        ),
      ),
      Text(
        appLang(context).shoppingCart,
        style: TextStyle(
          color: kAppRedColor,
        ),
      ),
      Text(
        appLang(context).category,
        style: TextStyle(
          color: kAppRedColor,
        ),
      ),
      Text(
        appLang(context).settings,
        style: TextStyle(
          color: kAppRedColor,
        ),
      ),
    ];
    if (index == 0) {
      isCenter = false;
    } else {
      isCenter = true;
    }
    return titleWidgets[index];
  }

  HomeModel homeModel;

  CategoriesModel categoriesModel;
  CategoriesDetailsModel categoriesDetailsModel;
  AddOrRemoveModel addOrRemoveModel;
  AddOrRemoveCartModel addOrRemoveCartModel;
  Map<int, bool> favourites = {};
  Map<int, bool> inCart = {};
  List<CategoryDetailsData> categoriesDetailsList = [];
  int quantity = 0;

  changeSelectedLanguage(int index) {
    selectedLanguageIndex = index;
    for (int i = 0; i < selectedLanguage.length; i++) {
      if (index == i) {
        selectedLanguage[i] = true;
      } else {
        selectedLanguage[i] = false;
      }
    }
    emit(AppSelectLanguageState());
  }

  AppLanguageModel languageModel;
  Future<void> setAppLanguage(
      {@required String translateFile, @required String code}) async {
    languageModel = AppLanguageModel.fromJson(json.decode(translateFile));
    setAppDirection(code: code);
    emit(AppSetLanguageState());
  }

  void setAppDirection({String code}) {
    textDirection = code == 'ar' ? TextDirection.rtl : TextDirection.ltr;
    isArabic = code == 'ar' ? true : false;
    emit(AppSetDirectionState());
  }

  int currentIndex = 0;
  void changeBottomIndex(int index) {
    currentIndex = index;
    emit(BottomIndexState());
  }

  void getHomeData() {
    emit(AppLoadingState());
    _repository
        .getHomeData(
      token: userToken,
    )
        .then(
      (value) {
        // print(value.data.toString());
        homeModel = HomeModel.fromJson(value.data);
        homeModel.data.products.forEach((element) {
          favourites.addAll({
            element.id: element.inFavorites,
          });
          inCart.addAll({
            element.id: element.inCart,
          });
        });
        print(inCart);
        print('Loading Cart Data');
        getCartData();

        emit(AppHomeSuccessState(homeModel));
        print(userToken);
      },
    ).catchError((error) {
      print(error.toString());
      // emit(AppErrorState(error));
    });
  }

  CartModel cartModel;
  List<CartItems> cartItems = [];
  int cartItemLength = 0;

  void getCartData() async {
    emit(AppLoadingCartDataState());
    print('Get user Token');
    userToken = await getUserToken;
    _repository
        .getCartData(
      token: userToken,
    )
        .then(
      (value) {
        cartModel = CartModel.fromJson(value.data);

        print('Loading Cart Data');
        print(cartModel.data);
        cartItemLength = cartModel.data.cartItems.length;
        cartItems = cartModel.data.cartItems;
        print(cartItems[0].product.name);
        emit(AppSuccessCartDataState());
      },
    ).catchError((error) {
      print(error.toString());
      // emit(CartErrorState(error));
    });
  }

  void getCategoriesData() {
    emit(AppLoadingCategoriesState());
    _repository.getCategoriesData().then((category) {
      categoriesModel = CategoriesModel.fromJson(category.data);
      emit(AppCategoriesSuccessState(categoriesModel));
    }).catchError((error) {
      print(error.toString());
      // emit(AppCategoriesErrorState(error));
    });
  }

  void addOrRemoveFav({
    @required int productId,
  }) {
    print(productId);
    favourites[productId] = !favourites[productId];

    emit(AppLoadingFavState(
      id: productId,
    ));
    _repository
        .addOrRemoveFav(
      token: userToken,
      productId: productId,
    )
        .then((value) {
      addOrRemoveModel = AddOrRemoveModel.fromJson(value.data);
      if (addOrRemoveModel.status == false) {
        favourites[productId] = !favourites[productId];
      }
      print(addOrRemoveModel.data.product.id);
      print(addOrRemoveModel.message);
      emit(AppSuccessFavState());
    }).catchError((error) {
      favourites[productId] = !favourites[productId];
      print(error.toString());
      emit(AppErrorFavState(error.toString()));
    });
  }

  void addOrRemoveToCart({
    @required int productId,
    @required context,
  }) {
    print(productId);
    inCart[productId] = !inCart[productId];

    emit(AppLoadingCartState());
    _repository
        .addOrRemoveToCart(
      token: userToken,
      productId: productId,
    )
        .then((value) {
      addOrRemoveCartModel = AddOrRemoveCartModel.fromJson(value.data);
      if (addOrRemoveCartModel.status == false) {
        inCart[productId] = !inCart[productId];
      }
      AppCubit.get(context).getCartData();
      emit(AppSuccessCartState());
    }).catchError((error) {
      inCart[productId] = !inCart[productId];
      print(error.toString());
      emit(AppErrorCartState(error.toString()));
    });
  }

  void updateCart({
    @required int productId,
    @required int quantity,
  }) {
    emit(AppUpdateCartLoading());
    _repository
        .updateCart(
      token: userToken,
      productId: productId,
      quantity: quantity,
    )
        .then((value) {
      getCartData();
      emit(AppSuccessCartState());
      print(value.data);
    }).catchError((error) {
      emit(AppUpdateCartError(error.toString()));
    });
  }

  Future<void> deleteCartItem({
    @required int productId,
    @required BuildContext context,
  }) async {
    emit(CartDeleteLoadingState());
    _repository
        .deleteCartItem(
      token: userToken,
      productId: productId,
    )
        .then((value) {
      print(value.data);
      emit(CartDeleteSuccessState());
      getCartData();
      getHomeData();
    });
  }

  void getCategoryDetails({@required categoryId, @required context}) {
    emit(CategoryDetailsLoadingState());

    _repository.getCategoryDetails(categoryId: categoryId).then((value) {
      print(value.data);
      categoriesDetailsModel = CategoriesDetailsModel.fromJson(value.data);
      categoriesDetailsList = categoriesDetailsModel.data.data;
      emit(CategoryDetailsSuccessState());
      navigateTo(context: context, widgetScreen: CategoryDetails());
    }).catchError((error) {
      emit(CategoryDetailsErrorState(error));
    });
  }
}
