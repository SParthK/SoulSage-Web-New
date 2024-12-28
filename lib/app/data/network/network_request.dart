import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart' as getx;

import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' as get_part;

import '../../../utils/app_utils.dart';
import '../../../utils/exception_handler.dart';
import '../api_service/config.dart';

Future<void> lunchAnyUrl({required String url}) async {
  try {
    // await launchUrl(Uri.parse(url));
  } catch (e) {}
}

Future<void> makePhoneCall({required String phoneNumber}) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  // await launchUrl(launchUri);
}

void sendWhatsAppMessage({required String phoneNumber}) async {
  final Uri launchUri = Uri(
    scheme: 'https',
    host: 'wa.me',
    path: phoneNumber,
  );
  // await launchUrl(launchUri);
}

void sendMail({required String email}) async {
  final Uri launchUri = Uri(
    scheme: 'mailto',
    path: email,
    query: 'subject=Help%20and%20Support&body=Describe%20your%20issue%20here',
  );
  // await launchUrl(launchUri);
}

void openDirection({required String lat, required String long}) async {
  // await launchUrl(
  //     Uri.parse("https://www.google.com/maps/search/?api=1&query=$lat,$long"));
}

class NetworkRequester {
  late Dio _dio;
  late Dio _formDio;

  NetworkRequester() {
    prepareRequest();
    prepareFormRequest();
  }

  void prepareRequest() {
    BaseOptions dioOptions = BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      baseUrl: Config.baseUrl,
      receiveDataWhenStatusError: true,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      headers: {'Accept': Headers.jsonContentType},
    );

    _dio = Dio(dioOptions);

    _dio.interceptors.clear();

    _dio.interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: false,
      logPrint: _printLog,
    ));
  }

  void prepareFormRequest() {
    BaseOptions dioOptions = BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        baseUrl: Config.baseUrl,
        contentType: "multipart/form-data",
        responseType: ResponseType.json);

    _formDio = Dio(dioOptions);

    _formDio.interceptors.clear();

    _formDio.interceptors.add(LogInterceptor(
      error: true,
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: false,
      logPrint: _printLog,
    ));
  }

  _printLog(Object object) => log(object.toString());
  getx.RxBool isGoingLogin = false.obs;

  Future<dynamic> get({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? jsonData,
    String? bearerToken, // New parameter for the bearer token
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: query,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': '$bearerToken'
          },
        ),
        data: jsonData != null ? json.encode(jsonData) : null,
      );
      return response.data;
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        if ((dioError.response?.data ?? "")
                .toString()
                .contains("Unauthorized") &&
            isGoingLogin.isFalse) {
          // isGoingLogin.value = true;
          // GetStorageBox.cleanAllStorage();
          // get_part.Get.offAllNamed(Routes.LOGIN);
          // Timer(const Duration(seconds: 5), () => isGoingLogin.value = false);
        }
        // If there is a response from the server
        log("API side catch response data: ${dioError.response?.data == "Unauthorized"}");
        log("API side catch response status code: ${dioError.response?.statusCode}");
        return dioError.response?.data;
      } else {
        // If there is no response from the server
        log("API side catch error: ${dioError.message}");
        return ExceptionHandler.handleError(dioError);
      }
    } catch (error) {
      log("API side catch other error: $error");
      return AppUtils.showToast(msg: "Something went wrong..");
    }
  }

/*
  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? bearerToken,
  }) async {
    // try {
      final Map<String, String> headers = {};

      if (bearerToken != null && bearerToken.isNotEmpty) {
        headers['Authorization'] = '$bearerToken';
      }

      final response = await _dio.post(
        path,
        queryParameters: query,
        data: data,
        options: Options(
          method: "POST",
          headers: headers,
        ),
      );
      print("api side try response : ${response.data}");
      return response.data;
    // } on Exception catch (error) {
    //   print("api side catch response : ${error}");
    //   return ExceptionHandler.handleError(error);
    // }
  }
*/

  Future<dynamic> post({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? bearerToken,
  }) async {
    try {
      final Map<String, String> headers = {};
      if (bearerToken != null && bearerToken.isNotEmpty) {
        headers['Authorization'] = bearerToken;
      }

      final response = await _dio.post(
        path,
        queryParameters: query,
        data: data,
        options: Options(
          method: "POST",
          headers: headers,
        ),
      );
      return response.data;
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        // If there is a response from the server
        log("API side catch response data: ${dioError.response?.data}");
        log("API side catch response status code: ${dioError.response?.statusCode}");
        return dioError.response?.data;
      } else {
        // If there is no response from the server
        log("API side catch error: ${dioError.message}");
        return ExceptionHandler.handleError(dioError);
      }
    } catch (error) {
      log("API side catch other error: $error");
      return AppUtils.showToast(msg: "Something went wrong..");
    }
  }

  checkForPermission() async {
    /*await Permission.mediaLibrary
        .onDeniedCallback(() {})
        .onGrantedCallback(() {})
        .onPermanentlyDeniedCallback(() {})
        .onRestrictedCallback(() {})
        .onLimitedCallback(() {})
        .onProvisionalCallback(() {})
        .request();
    await Permission.photos
        .onDeniedCallback(() {})
        .onGrantedCallback(() {})
        .onPermanentlyDeniedCallback(() {})
        .onRestrictedCallback(() {})
        .onLimitedCallback(() {})
        .onProvisionalCallback(() {})
        .request();*/
    // await Permission.storage
    //     .onDeniedCallback(() {})
    //     .onGrantedCallback(() {})
    //     .onPermanentlyDeniedCallback(() {})
    //     .onRestrictedCallback(() {})
    //     .onLimitedCallback(() {})
    //     .onProvisionalCallback(() {})
    //     .request();
  }

  Future<dynamic> uploadFile({
    required String url,
    required String filePath,
    String? bearerToken,
  }) async {
    await checkForPermission();
    try {
      final Map<String, String> headers = {};
      if (bearerToken != null && bearerToken.isNotEmpty) {
        headers['Authorization'] = '$bearerToken';
      }
      String fileName = filePath.split('/').last;
      String fileExtension = fileName.split('.').last;
      log("fileee Extension: $fileExtension");
      log("fileee path : --$filePath");
      log("fileee name : --${filePath.split('/').last}");

      List<dio.MultipartFile> files = [];

      dio.MultipartFile file = await dio.MultipartFile.fromFile(
        filePath,
        filename: fileName,
      );

      files.add(file);
      /* MultipartFile demoImg = await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      );
      FormData formData = FormData.fromMap({'file': demoImg});
*/
      // log("fileee formData : --${formData.files}");
      // log("fileee formData : --${formData.files.first.value.filename}");

      final response = await _formDio.post(
        url,
        data: {'file': files},
        options: Options(
          method: 'POST',
          headers: headers,
        ),
      );

      return response.data;
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        // If there is a response from the server
        log("API side catch response data: ${dioError.response?.data}");
        log("API side catch response status code: ${dioError.response?.statusCode}");
        return dioError.response?.data;
      } else {
        // If there is no response from the server
        log("API side catch error: ${dioError.message}");
        return {"error": dioError.message};
      }
    } catch (error) {
      log("API side catch other error: $error");
      return {"error": error.toString()};
    }
  }

  Future<dynamic> put({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? bearerToken,
  }) async {
    try {
      final Map<String, String> headers = {};

      if (bearerToken != null && bearerToken.isNotEmpty) {
        headers['Authorization'] = '$bearerToken';
      }

      final response = await _dio.put(
        path,
        queryParameters: query,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
      return response.data;
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        // If there is a response from the server
        log("API side catch response data: ${dioError.response?.data}");
        log("API side catch response status code: ${dioError.response?.statusCode}");
        return dioError.response?.data;
      } else {
        // If there is no response from the server
        log("API side catch error: ${dioError.message}");
        return ExceptionHandler.handleError(dioError);
      }
    } catch (error) {
      log("API side catch other error: $error");
      return AppUtils.showToast(msg: "Something went wrong..");
    }
  }

  Future<dynamic> patch({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? bearerToken,
  }) async {
    try {
      final Map<String, String> headers = {};

      if (bearerToken != null && bearerToken.isNotEmpty) {
        headers['Authorization'] = '$bearerToken';
      }
      final response = await _dio.patch(
        path,
        queryParameters: query,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
      return response.data;
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        // If there is a response from the server
        log("API side catch response data: ${dioError.response?.data}");
        log("API side catch response status code: ${dioError.response?.statusCode}");
        return dioError.response?.data;
      } else {
        // If there is no response from the server
        log("API side catch error: ${dioError.message}");
        return ExceptionHandler.handleError(dioError);
      }
    } catch (error) {
      log("API side catch other error: $error");
      return AppUtils.showToast(msg: "Something went wrong..");
    }
  }

  Future<dynamic> delete({
    required String path,
    Map<String, dynamic>? query,
    Map<String, dynamic>? data,
    String? bearerToken,
  }) async {
    try {
      final Map<String, String> headers = {};

      if (bearerToken != null && bearerToken.isNotEmpty) {
        headers['Authorization'] = '$bearerToken';
      }

      final response = await _dio.delete(
        path,
        queryParameters: query,
        data: data,
        options: Options(
          headers: headers,
        ),
      );
      return response.data;
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        // If there is a response from the server
        log("API side catch response data: ${dioError.response?.data}");
        log("API side catch response status code: ${dioError.response?.statusCode}");
        return dioError.response?.data;
      } else {
        // If there is no response from the server
        log("API side catch error: ${dioError.message}");
        return ExceptionHandler.handleError(dioError);
      }
    } catch (error) {
      log("API side catch other error: $error");
      return AppUtils.showToast(msg: "Something went wrong..");
    }
  }

  Future downloadFile(
      {required String path,
      Map<String, dynamic>? query,
      var showDownloadProgress}) async {
    Dio dio = Dio();

    dio.interceptors.addAll([
      LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
      )
    ]);
    try {
      Response response = await dio.get(
        path,
        queryParameters: query,
        onReceiveProgress: showDownloadProgress,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }),
      );
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<dynamic> download(
      {required String url,
      required String savePath,
      required Function(int i, int y) callback}) async {
    Dio dio = Dio();
    try {
      final response =
          await dio.download(url, savePath, onReceiveProgress: callback);
      return response.data;
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        // If there is a response from the server
        log("API side catch response data: ${dioError.response?.data}");
        log("API side catch response status code: ${dioError.response?.statusCode}");
        return dioError.response?.data;
      } else {
        // If there is no response from the server
        log("API side catch error: ${dioError.message}");
        return ExceptionHandler.handleError(dioError);
      }
    } catch (error) {
      log("API side catch other error: $error");
      return AppUtils.showToast(msg: "Something went wrong..");
    }
  }

  postFormData({
    required String path,
    required Map<String, dynamic> data,
    String? bearerToken,
  }) async {
    try {
      final Map<String, String> headers = {};

      if (bearerToken != null && bearerToken.isNotEmpty) {
        headers['Authorization'] = '$bearerToken';
      }

      final response = await _formDio.post(
        path,
        data: FormData.fromMap(data),
        options: Options(
          headers: headers,
        ),
      );
      return response.data;
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        // If there is a response from the server
        log("API side catch response data: ${dioError.response?.data}");
        log("API side catch response status code: ${dioError.response?.statusCode}");
        return dioError.response?.data;
      } else {
        // If there is no response from the server
        log("API side catch error: ${dioError.message}");
        return ExceptionHandler.handleError(dioError);
      }
    } catch (error) {
      log("API side catch other error: $error");
      return AppUtils.showToast(msg: "Something went wrong..");
    }
  }

  patchFormData({
    required String path,
    required Map<String, dynamic> data,
    String? bearerToken,
  }) async {
    try {
      final Map<String, String> headers = {};

      if (bearerToken != null && bearerToken.isNotEmpty) {
        headers['Authorization'] = '$bearerToken';
      }

      final response = await _formDio.patch(
        path,
        data: FormData.fromMap(data),
        options: Options(
          headers: headers,
        ),
      );
      return response.data;
    } on DioException catch (dioError) {
      if (dioError.response != null) {
        // If there is a response from the server
        log("API side catch response data: ${dioError.response?.data}");
        log("API side catch response status code: ${dioError.response?.statusCode}");
        return dioError.response?.data;
      } else {
        // If there is no response from the server
        log("API side catch error: ${dioError.message}");
        return ExceptionHandler.handleError(dioError);
      }
    } catch (error) {
      log("API side catch other error: $error");
      return AppUtils.showToast(msg: "Something went wrong..");
    }
  }

  putFormData({
    required String path,
    Map<String, dynamic>? data,
    String? bearerToken,
  }) async {
    final Map<String, String> headers = {};

    if (bearerToken != null && bearerToken.isNotEmpty) {
      headers['Authorization'] = '$bearerToken';
    }

    try {
      final response = await _formDio.put(
        path,
        data: FormData.fromMap(data!),
        options: Options(
          headers: headers,
        ),
      );
      return response.data;
    } on Exception catch (error) {
      return ExceptionHandler.handleError(error);
    }
  }

// Future downloadFile({required String path}) async {
//   Dio dio = Dio();
//   try {
//     var response = await dio.get(
//       path,
//       options: Options(responseType: ResponseType.bytes),
//     );
//     return response.data;
//   } on Exception catch (exception) {
//     return ExceptionHandler.handleError(exception);
//   }
// }
}
