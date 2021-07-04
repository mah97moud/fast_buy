import 'package:buy_now_demo/shared/components/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class DioHelper {
  Future<Response> postData({
    @required String url,
    @required dynamic data,
    String token,
  });

  Future<Response> putData({
    @required String url,
    @required dynamic data,
    String token,
  });

  Future<Response> getData({
    @required String url,
    dynamic query,
    String token,
  });
  Future<Response> deleteData({
    @required String url,
    String token,
  });
}

class DioImplementation extends DioHelper {
  final Dio _dio = Dio(
    BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
        followRedirects: false,
        headers: {
          'Content-Type': 'application/json',
        }),
  );
  @override
  Future<Response> getData({String url, dynamic query, String token}) async {
    _dio.options.headers = {
      'lang': appLanguage,
      'Authorization': token ?? '',
    };
    return await _dio.get(
      url,
      queryParameters: query,
    );
  }

  @override
  Future<Response> postData({String url, data, String token}) async {
    _dio.options.headers = {
      'lang': appLanguage,
      'Authorization': token ?? '',
    };
    return await _dio.post(
      url,
      data: data,
    );
  }

  @override
  Future<Response> putData({String url, data, String token}) async {
    _dio.options.headers = {
      'lang': appLanguage,
      'Authorization': token ?? '',
    };

    return await _dio.put(
      url,
      data: data,
    );
  }

  @override
  Future<Response> deleteData({String url, String token}) async {
    _dio.options.headers = {
      'lang': appLanguage,
      'Authorization': token ?? '',
    };

    return await _dio.delete(url);
  }
}
