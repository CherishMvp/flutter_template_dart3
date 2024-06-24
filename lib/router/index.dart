import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';
import '../components/user/detail_page.dart';
import '../components/user/home.dart';
import '../components/user/login_page.dart';
import '../components/user/profile_page.dart';
import '../provider/auth_provider.dart';

GoRouter get approuter => AppRouter.router;

class AppRouter {
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<void> setLoginStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', status);
  }

  static final GoRouter router = GoRouter(
    initialLocation: '/home', // 指定初始页面
    // 全局重定向
    redirect: (context, state) async {},
    routes: [
      GoRoute(
        path: '/home',
        pageBuilder: (context, state) => SwipeablePage(
          builder: (context) => const Home(),
        ),
      ),
      // 模拟页面传参
      GoRoute(
        path: '/detail/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return DetailPage(id: id);
        },
      ),
      // 模拟登录
      GoRoute(
        path: '/login',
         pageBuilder: (context, state) => SwipeablePage(
          builder: (context) => const LoginPage(),
        ),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfilePage(),
        redirect: (context, state) async {
          final authProvider =
              Provider.of<AuthProvider>(context, listen: false);
          await authProvider.loadLoginStatus();
          print("登录状态${authProvider.isLoggedIn}");
          return authProvider.isLoggedIn
              ? null
              : '/login'; //基于登录状态的重定向，如果未登录则跳转到登录页
        },
      ),
    ],
  );

  static CustomTransitionPage<void> animateRoute(
      GoRouterState state, Widget widget) {
    return CustomTransitionPage<void>(
      key: state.pageKey,
      child: widget,
      transitionDuration: const Duration(milliseconds: 150),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) {
        // 使用SlideTransition实现从小往上的动画
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
