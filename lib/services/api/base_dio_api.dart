import 'dart:io';

import 'package:coladaapp/utils/failure.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class BaseDioApi {
  final Dio _dio = Dio();
  late Response _response;
  final String url;
  BaseDioApi(this.url);

  Map<String, dynamic> queryParameters() {
    return {};
  }

  dynamic body() {}

  Future<Map<String, dynamic>> postRequest() async {
    debugPrint('url $url');
    debugPrint('body ${body()}');

    try {
      _response = await _dio.post(
        url,
        options: Options(
          headers: {
            'Authorization': '',
          },
        ),
        queryParameters: queryParameters(),
        data: body(),
      );

      return _response.data;
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          throw Failure("Timeout request");
        case DioErrorType.response:
          debugPrint(e.response?.statusMessage);
          throw Failure(e.error.toString());
        case DioErrorType.cancel:
          throw Failure("Request cancelled");
        case DioErrorType.other:
          {
            if (e.error is SocketException) {
              throw Failure('No Internet connection');
            } else if (e.error is FormatException) {
              throw Failure("Bad response format");
            } else {
              throw Failure("Something Wrong");
            }
          }
      }
    }
  }

  Future<Map<String, dynamic>> getRequest() async {
    debugPrint('url $url');
    debugPrint('queryParameters ${queryParameters()}');
    try {
      _response = await _dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': '',
          },
        ),
        queryParameters: queryParameters(),
      );
      return _response.data;
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          throw Failure("Timeout request");
        case DioErrorType.response:
          debugPrint(e.response?.statusMessage);
          throw Failure(e.error.toString());
        case DioErrorType.cancel:
          throw Failure("Request cancelled");
        case DioErrorType.other:
          {
            if (e.error is SocketException) {
              throw Failure('No Internet connection');
            } else if (e.error is FormatException) {
              throw Failure("Bad response format");
            } else {
              throw Failure("Something Wrong");
            }
          }
      }
    }
  }

  Future<Map<String, dynamic>> putRequest() async {
    try {
      _response = await _dio.put(
        url,
        options: Options(
          headers: {
            'Authorization': '',
          },
        ),
        queryParameters: queryParameters(),
        data: body(),
      );
      return _response.data;
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          throw Failure("Timeout request");
        case DioErrorType.response:
          throw Failure(e.error.toString());
        case DioErrorType.cancel:
          throw Failure("Request cancelled");
        case DioErrorType.other:
          {
            if (e.error is SocketException) {
              throw Failure('No Internet connection');
            } else if (e.error is FormatException) {
              throw Failure("Bad response format");
            } else {
              throw Failure("Something Wrong");
            }
          }
      }
    }
  }

  Future<Map<String, dynamic>> deleteRequest() async {
    try {
      _response = await _dio.delete(
        url,
        options: Options(
          headers: {
            'Authorization': '',
          },
        ),
        queryParameters: queryParameters(),
        data: body(),
      );
      return _response.data;
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.connectTimeout:
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
          throw Failure("Timeout request");
        case DioErrorType.response:
          throw Failure(e.error.toString());
        case DioErrorType.cancel:
          throw Failure("Request cancelled");
        case DioErrorType.other:
          {
            if (e.error is SocketException) {
              throw Failure('No Internet connection');
            } else if (e.error is FormatException) {
              throw Failure("Bad response format");
            } else {
              throw Failure("Something Wrong");
            }
          }
      }
    }
  }
}
