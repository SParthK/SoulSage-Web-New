import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../components/Helpers/shared_pref_helper.dart';
import 'config.dart';

late Dio _dio;

class APIProvider {
  APIProvider() {
    _dio = Dio();
  }

  Future<Response<dynamic>> getAPICall(String url,
      {Map<String, dynamic>? header}) async {
    String uri = Config.baseUrl + url;
    log("uri ==================> $uri");

    log("header ==================> $header");
    final Response<dynamic> response =
        await _dio.get(uri, options: Options(headers: header));
    throwIfNoSuccess(response);
    log("response ==================> $response");
    if (response.data is Map &&
        response.data["code"] != null &&
        int.parse(response.data["code"]) == 401) {
      SharedPref.deleteAll();
    }
    return response;
  }


  Future<Response<dynamic>> getAPICallWithQueryParam(
      String url, dynamic data, Map<String, dynamic>? header) async {
    String uri = Config.baseUrl + url;
    log("uri ==================> $uri");
    log("header ==================> $header");
    final Response<dynamic> response = await _dio.get(uri,
        queryParameters: data as Map<String, dynamic>,
        options: Options(headers: header));
    throwIfNoSuccess(response);
    log("response ==================> $response");
    if (response.data["code"] == 401) {
      SharedPref.deleteAll();
    }
    return response;
  }

  Future<Response<dynamic>> postAPICall(
      {required String url, required dynamic data, Map<String, dynamic>? header}) async {
    String uri = Config.baseUrl + url;
    log("uri ==================> $uri");
    log("header ==================> $header");
    log("body ==================> $data");
    Response<dynamic> response = await _dio.post(uri,
        data: data,
        options: Options(
          headers: header ??  {
            'Content-Type': 'application/json',
          },
        ));
    throwIfNoSuccess(response);
    log("response ==================> $response");
    if (response.statusCode == 401) {
      SharedPref.deleteAll();
    }
    return response;
  }

  void throwIfNoSuccess(response) {
    log("Response statusCode==================> ${response.statusCode}");
    if (response.statusCode! < 200 || response.statusCode! > 299) {
      throw HttpException(response);
    }else{

    }
  }

  void throwIfNoSuccessInMultipart(response) {
    log("Response statusCode==================> ${response["code"]}");
    if (response["code"]! > 100 || response["code"]! >= 500) {
      if (kDebugMode) {
        log(response["code"]);
      }
      throw HttpException(response);
    }
  }
}

class HttpException implements Exception {
  HttpException(this.response);

  Response<dynamic> response;
}

String handleDioError(Object? error) {
  log("error is =============> ${error.toString()}");
  EasyLoading.dismiss();
  if (error is DioError) {
    if (error.response?.statusCode == 401) {
      SharedPref.deleteAll();
    } else if (error.response?.statusCode == 400) {
      return "Error in Register With statusCode ${error.response?.statusCode}";
    } else {
      return "Something went wrong!";
    }
  }
  return error.toString();
}
