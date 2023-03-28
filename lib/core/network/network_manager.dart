import 'dart:io';

import 'package:dio/dio.dart';
import 'package:lifeapp/core/network/network_route_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NetworkException.dart';

class NetworkManager {
  Dio dio = Dio(BaseOptions(
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      validateStatus: (_) => true))
    ..options.baseUrl = NetworkRoutes.baseUrlProduction.rawValue
    ..options.connectTimeout = 10000
    ..options.receiveTimeout
    ..options.headers = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    }
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          var token = prefs.getString("token");
          options.headers.putIfAbsent("Authorization", () => "Bearer $token");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          if (e.type == DioErrorType.other) {
          } else if (e.type == DioErrorType.connectTimeout) {}

          return handler.next(e);
        },
      ),
    );

  Future<dynamic> post(String url, dynamic data) async {
    return await dio.post(url, data: data);
  }

  Future<dynamic> get(String url) async {
    return await dio.get(url);
  }

  Future<dynamic> postRequest(
    String url, {
    Object? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      Response response = await dio.post(url, data: body);
      return _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> putRequest(String url,
      {Object? body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await dio.put(
        url,
        data: body,
      );
      return _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> deleteRequest(String url,
      {Object? body,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await dio.delete(
        url,
        data: body,
      );
      return _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> getRequest(String url,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      Response response = await dio.get(
        url,
      );
      return _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return response.data;
      case 400:
        throw BadRequestException(response.data['message']);
      case 401:
      case 403:
        throw UnauthorisedException(response.data['message']);
      case 500:
      default:
        throw FetchDataException(
            'Error while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
