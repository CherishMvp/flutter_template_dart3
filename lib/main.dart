import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_template_simple/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'generated/l10n.dart';
import 'router/index.dart';
import 'themes/index.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => AuthProvider(AppRouter.router)),
      Provider(
          create: (_) =>
              AppRouter.router), //注入route路由表到上下文。待会在AuthProvider要注入使用
      ChangeNotifierProvider(
        create: (context) => AuthProvider(context.read<GoRouter>()),
      )
      // 添加其他需要共享的Provider
    ],
    child: const MainApp(),
  ));
  // 延时两秒
  // Future.delayed(const Duration(seconds: 2));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  RouteObserver routeObserver = RouteObserver();
  // Locale _appLocale = window.locale;
  final Locale _appLocale = const Locale('zh', 'CN'); //设置语言默认为中文

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return ChangeNotifierProvider(
        create: (context) => ThemeController(),
        child: Consumer<ThemeController>(
            builder: (context, themeController, child) {
          var materialApp = MaterialApp.router(
            routerConfig: AppRouter.router, //路由配置
            // 注：这里可以添加多个 NavigatorObserver
            debugShowCheckedModeBanner: false,
            theme: themeController.themeLight(),
            darkTheme: themeController.themeDark(),
            themeMode: ThemeMode.system,
            localizationsDelegates: const [
              // 2
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate
            ],
            locale: _appLocale,
            supportedLocales: S.delegate.supportedLocales,
            localeResolutionCallback: (locale, supportedLocales) {
              // 如果语言是英语
              if (locale?.languageCode == 'en') {
                //注意大小写，返回美国英语
                return const Locale('en', 'US');
              } else {
                return locale;
              }
            },
            onGenerateTitle: (context) {
              return S.of(context).title;
            }, //不能直接设置title，因为没有父树
          );
          return materialApp;
        }));
  }
}
