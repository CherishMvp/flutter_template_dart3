import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  /// 计算颜色
  Color brightenColor(Color color, [double factor = 0.2]) {
    assert(factor >= 0 && factor <= 1, 'Factor should be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final brightened = hsl.withLightness((hsl.lightness + factor).clamp(0, 1));

    return brightened.toColor();
  }

  void toggleTheme(value) {
    _isDarkMode = value;
    notifyListeners();
  }

// 使用flex_color_scheme设置主题
  ThemeData themeLight() {
    return FlexThemeData.light(
      scheme: FlexScheme.ebonyClay,
      surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
      blendLevel: 2,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        blendTextTheme: true,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,
        outlinedButtonPressedBorderWidth: 2.0,
        toggleButtonsBorderSchemeColor: SchemeColor.primary,
        segmentedButtonSchemeColor: SchemeColor.primary,
        segmentedButtonBorderSchemeColor: SchemeColor.primary,
        unselectedToggleIsColored: true,
        sliderValueTinted: true,
        inputDecoratorSchemeColor: SchemeColor.primary,
        inputDecoratorBackgroundAlpha: 21,
        inputDecoratorRadius: 12.0,
        inputDecoratorUnfocusedHasBorder: false,
        inputDecoratorPrefixIconSchemeColor: SchemeColor.primary,
        popupMenuRadius: 6.0,
        popupMenuElevation: 8.0,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
        drawerIndicatorSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedLabel: false,
        bottomNavigationBarMutedUnselectedIcon: false,
        menuRadius: 6.0,
        menuElevation: 8.0,
        menuBarRadius: 0.0,
        menuBarElevation: 1.0,
        navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        navigationBarMutedUnselectedLabel: false,
        navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationBarMutedUnselectedIcon: false,
        navigationBarIndicatorSchemeColor: SchemeColor.primary,
        navigationBarIndicatorOpacity: 1.00,
        navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
        navigationRailMutedUnselectedLabel: false,
        navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationRailMutedUnselectedIcon: false,
        navigationRailIndicatorSchemeColor: SchemeColor.primary,
        navigationRailIndicatorOpacity: 1.00,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }

  ThemeData themeDark() {
    return FlexThemeData.dark(
      scheme: FlexScheme.ebonyClay,
      surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
      blendLevel: 8,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 8,
        blendTextTheme: true,
        useTextTheme: true,
        useM2StyleDividerInM3: true,
        outlinedButtonOutlineSchemeColor: SchemeColor.primary,
        outlinedButtonPressedBorderWidth: 2.0,
        toggleButtonsBorderSchemeColor: SchemeColor.primary,
        segmentedButtonSchemeColor: SchemeColor.primary,
        segmentedButtonBorderSchemeColor: SchemeColor.primary,
        unselectedToggleIsColored: true,
        sliderValueTinted: true,
        inputDecoratorSchemeColor: SchemeColor.primary,
        inputDecoratorBackgroundAlpha: 43,
        inputDecoratorRadius: 12.0,
        inputDecoratorUnfocusedHasBorder: false,
        popupMenuRadius: 6.0,
        popupMenuElevation: 8.0,
        alignedDropdown: true,
        useInputDecoratorThemeInDialogs: true,
        drawerIndicatorSchemeColor: SchemeColor.primary,
        bottomNavigationBarMutedUnselectedLabel: false,
        bottomNavigationBarMutedUnselectedIcon: false,
        menuRadius: 6.0,
        menuElevation: 8.0,
        menuBarRadius: 0.0,
        menuBarElevation: 1.0,
        navigationBarSelectedLabelSchemeColor: SchemeColor.primary,
        navigationBarMutedUnselectedLabel: false,
        navigationBarSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationBarMutedUnselectedIcon: false,
        navigationBarIndicatorSchemeColor: SchemeColor.primary,
        navigationBarIndicatorOpacity: 1.00,
        navigationRailSelectedLabelSchemeColor: SchemeColor.primary,
        navigationRailMutedUnselectedLabel: false,
        navigationRailSelectedIconSchemeColor: SchemeColor.onPrimary,
        navigationRailMutedUnselectedIcon: false,
        navigationRailIndicatorSchemeColor: SchemeColor.primary,
        navigationRailIndicatorOpacity: 1.00,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
    );
  }
}
