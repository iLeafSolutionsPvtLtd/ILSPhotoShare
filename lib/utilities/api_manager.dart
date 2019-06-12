import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart';
import 'package:photo_share/utilities/stringConstants.dart';
import 'package:photo_share/utilities/user_manager.dart';

class APIManager {
  static Client _client = Client();
  static beginRequest() {}
  static Future<ResponseModel> request(
      {params: dynamic,
      url: String,
      requestType: RequestType,
      beginCallback: Function}) async {
    print(
        'URL........................................................................');
    print(url);
    print(
        'Request........................................................................');
    print(params.toString());
    String token = await UserManager.getToken();
    var dio = new Dio(new BaseOptions(
      baseUrl: baseURL,
      connectTimeout: 50000,
      receiveTimeout: 100000,
      followRedirects: false,
      validateStatus: (status) {
        return status < 500;
      },
      headers: {
        "Authorization": "Bearer $token",
      },
      contentType: ContentType.json,
      responseType: ResponseType.json,
    ));
    switch (requestType) {
      case RequestType.get:
        return await dio
            .get(
          url,
        )
            .then((response) {
          print(
              'Response........................................................................');
          print(response.data.toString());
          if (response.statusCode == 400) {
            return ResponseModel(null, ResponseStatus.error404);
          } else if (response.statusCode >= 500) {
            return ResponseModel(null, ResponseStatus.error500);
          } else {
            return ResponseModel(response.data, ResponseStatus.success200);
          }
        });
        break;
      case RequestType.post:
        return await dio
            .post(
          url,
          data: params,
          options: new Options(
              contentType:
                  ContentType.parse("application/x-www-form-urlencoded")),
        )
            .then((res) {
          print(res.data.toString());

          if (res.statusCode == 400) {
            return ResponseModel(null, ResponseStatus.error404);
          } else if (res.statusCode >= 500) {
            return ResponseModel(null, ResponseStatus.error500);
          } else {
            return ResponseModel(res.data, ResponseStatus.success200);
          }
        });
    }
    return null;
  }
}

enum RequestType { get, post, put, patch, delete }
enum ResponseStatus { success200, error404, error500, error401 }

class ResponseModel {
  final data;
  final ResponseStatus status;
  ResponseModel(this.data, this.status);
}
