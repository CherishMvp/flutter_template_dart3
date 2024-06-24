// auth_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '/api/request.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;
  // final GoRouter _router = approuter;
  final GoRouter _router;

  AuthProvider(this._router) {
    loadLoginStatus(); //注入这个地方无法做到异步执行
  }

  Future<void> loadLoginStatus() async {
    final token = await _storage.read(key: 'auth_token');
    print("立即读取token$token");
    _isLoggedIn = token != null;
    notifyListeners();
  }

// ...

  Future<void> login(String username, String password) async {
    // 创建一个Dio实例
    final Request customDio = Request();

    // 模拟后端请求进行登录验证
    // Map<String, dynamic> postData = {
    //   'username': username,
    //   'password': password
    // };
    // final MyResponse response = await customDio.post(
    //   '/onesignal/login',
    //   postData,
    // );
    const mockLogin = true;
    if (mockLogin) {
      // 假设后端返回一个Token
      const token = "asdjgahsd";
      await _storage.write(key: 'auth_token', value: token);
      _isLoggedIn = true;
      _router.replace('/profile'); // 使用replace方法
      print("登录成功$_isLoggedIn");
      notifyListeners();
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    _isLoggedIn = false;
    notifyListeners();
  }
}
