import 'package:flutter/material.dart';

import 'helper/cache/cache_helper.dart';

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({
    super.key,
    required this.mobileScreen,
    this.tabletScreen,
    required this.desktopScreen,
  });

  final Widget mobileScreen;
  final Widget? tabletScreen;
  final Widget desktopScreen;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
      MediaQuery.of(context).size.width >= 600;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return desktopScreen;
        } else if (constraints.maxWidth >= 600) {
          return tabletScreen ?? mobileScreen;
        } else {
          return mobileScreen;
        }
      },
    );
  }

  static Color setColorTheme(Color lightColor, Color darkColor, context) {
    bool? isDarkMode = CacheHelper.getData(key: "isDark");
    if (isDarkMode == null) {
      return lightColor;
    } else {
      return isDarkMode ? darkColor : lightColor;
    }
  }
}
