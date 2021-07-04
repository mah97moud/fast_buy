import 'package:buy_now_demo/shared/network/end_points.dart';
import 'package:buy_now_demo/shared/network/local/cache_helper.dart';
import 'package:buy_now_demo/shared/network/remote/dio_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'end_points.dart';

abstract class Repository {
  Future<Response> userLogin({
    @required String email,
    @required String password,
  });
  Future<Response> userSignUp({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  });
  Future<Response> getHomeData({
    @required String token,
  });
  Future<Response> getCartData({
    @required String token,
  });
  Future<Response> getCategoriesData();

  Future<Response> addOrRemoveFav({
    @required String token,
    @required int productId,
  });
  Future<Response> addOrRemoveToCart({
    @required String token,
    @required int productId,
  });
  Future<Response> deleteCartItem({
    @required String token,
    @required int productId,
  });
  Future<Response> updateCart({
    @required String token,
    @required int productId,
    @required int quantity,
  });
  Future<Response> getCategoryDetails({
    @required int categoryId,
  });
}

class RepositoryImplementation extends Repository {
  final DioHelper _dioHelper;
  // ignore: unused_field
  final CacheHelper _cacheHelper;

  RepositoryImplementation(
    this._dioHelper,
    this._cacheHelper,
  );

  @override
  Future<Response> userLogin({String email, String password}) async {
    return await _dioHelper.postData(
      url: LOGIN_URL,
      data: {
        "email": email,
        "password": password,
      },
    );
  }

  @override
  Future<Response> getHomeData({String token}) async {
    return await _dioHelper.getData(
      url: HOME_URL,
      token: token,
    );
  }

  @override
  Future<Response> getCategoriesData() async {
    return await _dioHelper.getData(url: CATEGORIES_URL);
  }

  @override
  Future<Response> addOrRemoveFav({
    @required String token,
    @required int productId,
  }) async {
    return await _dioHelper.postData(
      url: FAVOURITES_URL,
      data: {
        "product_id": productId,
      },
      token: token,
    );
  }

  @override
  Future<Response> addOrRemoveToCart({
    @required String token,
    @required int productId,
  }) async {
    return await _dioHelper.postData(
      url: CART_URL,
      token: token,
      data: {"product_id": productId},
    );
  }

  @override
  Future<Response> getCartData({@required String token}) async {
    return await _dioHelper.getData(
      url: CART_URL,
      token: token,
    );
  }

  @override
  Future<Response> updateCart({
    String token,
    int productId,
    int quantity,
  }) async {
    return await _dioHelper.putData(
      url: '$CART_URL/$productId',
      data: {
        "quantity": quantity,
      },
      token: token,
    );
  }

  @override
  Future<Response> getCategoryDetails({int categoryId}) async {
    return await _dioHelper.getData(
      url: '$CATEGORIES_URL/$categoryId',
    );
  }

  @override
  Future<Response> userSignUp(
      {String email, String password, String name, String phone}) async {
    return await _dioHelper.postData(
      url: REGISTER_URL,
      data: {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
      },
    );
  }

  @override
  Future<Response> deleteCartItem({String token, int productId}) async {
    return await _dioHelper.deleteData(
      url: '$CART_URL/$productId',
      token: token,
    );
  }
}
