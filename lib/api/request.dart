import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const String prefix = '/Quote';

/// 自定义Response响应结构体
class MyResponse {
  final int status;
  final String msg;
  final dynamic data;

  MyResponse({required this.status, required this.msg, required this.data});

  factory MyResponse.fromJson(Map<String, dynamic> json) {
    return MyResponse(
      status: json['status'],
      msg: json['msg'],
      data: json['data'],
    );
  }
}

class Request {
  final Dio _dio = Dio(
    BaseOptions(
      // baseUrl: "https://reqres.in",
      baseUrl: 'http://127.0.0.1:9001$prefix',
      connectTimeout: const Duration(milliseconds: 5000),
      receiveTimeout: const Duration(milliseconds: 3000),
    ),
  );

  Request() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        if (response.statusCode == 200) {}
        // 200成功状态(直接返回data内容)
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response;
    } on DioException catch (e) {
      throw Exception('Failed to make get request: $e');
    }
  }

  Future<MyResponse> post(String path, dynamic data) async {
    try {
      Response response = await _dio.post(path, data: data);
      return MyResponse.fromJson(jsonDecode(response.data));
    } on DioException catch (e) {
      throw Exception('Failed to make post request: $e');
    }
  }
}

/// example:
final Request customDio = Request();
void main() async {
  // Request customDio = Request();

  try {
    Map<String, dynamic> postData = {
      'name': 'John Doe',
      'email': 'john@example.com'
    };
    final response = await customDio.post('/users', postData);
    if (kDebugMode) {
      print(response);
    }
  } on DioException catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
}
