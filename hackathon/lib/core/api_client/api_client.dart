import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hackathon/core/api_client/api_exception.dart';
import 'package:hackathon/core/api_client/api_result.dart';

import 'header_interceptor.dart';

typedef JsonMap = Map<String, dynamic>;

enum Backend { main, reporting }

class ApiClient {
  static final ApiClient _instance = ApiClient.internal();
  static late Dio _dio;
  static ApiResult apiResult = ApiResult();

  ApiClient.internal() {
    _dio = Dio()
      ..interceptors.add(AuthInterceptor())
      ..interceptors.add(LogInterceptor(responseBody: true, logPrint: _log));
  }

  factory ApiClient() => _instance;

  CancelToken _cancelToken = CancelToken();

  Future get(url,
      {Map<String, dynamic>? headers,
      Backend? backend,
      Map<String, dynamic>? queryParams}) async {
    try {
      url = url;
      Response response = await _dio.get(
        url,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future<dynamic> post(url,
      {JsonMap? body,
      Map<String, dynamic>? headers,
      Backend? backend,
      Map<String, dynamic>? queryParams}) async {
    try {
      url = url;
      Response response = await _dio.post(
        url,
        data: body,
        queryParameters: queryParams,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future update(
    String url, {
    required JsonMap body,
    Map<String, dynamic>? headers,
    Backend? backend,
  }) async {
    try {
      url = url;
      Response response = await _dio.put(
        url,
        data: body,
        options: Options(headers: headers),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future delete(
    String url, {
    required JsonMap body,
    Map<String, dynamic>? header,
    Backend? backend,
  }) async {
    try {
      url = url;
      Response response = await _dio.delete(
        url,
        data: body,
        options: Options(headers: header),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future uploadMediaRequest(
    String url, {
    required List<String> imagePath,
    Backend? backend,
  }) async {
    Map<String, dynamic> headerWithToken = {
      'accept': 'application/json',
      'Content-Type': 'application/json',
    };
    FormData formData = FormData();
    for (var element in imagePath) {
      log('elemen  $element');
      final filename = element.split('/').last.split('.').first;
      formData.files.add(MapEntry(
          'file',
          await MultipartFile.fromFile(
            element,
            filename: filename,
          )));
    }
    log('form data$formData');

    try {
      url = url;
      Response response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: headerWithToken),
        cancelToken: _cancelToken,
      );
      return response.data;
    } catch (error) {
      return _handleError(url, error);
    }
  }

  Future<Map<String, dynamic>> _handleError(String path, Object error) {
    if (error is DioException) {
      final method = error.requestOptions.method;
      final response = error.response;

      apiResult.setStatusCode(response?.statusCode);

      final data = response?.data;
      int? statusCode = response?.statusCode;
      if (statusCode == 401) {
        // SecureStorageHelper.instance.deleteAll();
        // getX.Get.deleteAll();
        // getX.Get.put(LoginController());
        // getX.Get.put(DashBoardController());
        // Navigator.pushReplacementNamed(
        //     getX.Get.context!, RouteName.usertypeSelectionScreen);
      } else {}

      if (error.type == DioExceptionType.connectionTimeout||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        statusCode = HttpStatus
            .requestTimeout; //Set the error code to 408 in case of timeout
      }
      throw ApiException(
        errorMessage: response?.data != null ? (response?.data?['message']??'') : '',
        path: path,
        message: 'received server error $statusCode while $method data',
        response: data.toString(),
        statusCode: statusCode,
        method: method,
      );
    } else {
      int errorCode = 0; //We will send a default error code as 0

      throw ApiException(
        path: path,
        message: 'received server error $errorCode',
        response: error.toString(),
        statusCode: errorCode,
        method: '',
      );
    }
  }

  ///Creates the url for different backend micro services
  String _createApiUrl(String url, Backend? backend) {
    switch (backend) {
      case Backend.reporting:
        return url;
      default:
        return url;
    }
  }

  void _log(Object object) {
    log("$object");
  }
}