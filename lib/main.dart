import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_search/helper/db_helper.dart';
import 'package:infinite_scroll_search/resourese/service/app_service.dart';
import 'package:infinite_scroll_search/routes/pages.dart';
import 'package:infinite_scroll_search/theme/app_theme_util.dart';
import 'package:infinite_scroll_search/theme/base_theme_data.dart';
import 'package:infinite_scroll_search/widget/reponsive/size_config.dart';

AppThemeUtil themeUtil = AppThemeUtil();
BaseThemeData get appTheme => themeUtil.getAppTheme();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppService.initAppService();
  await DBHelper.initDB();

  runApp(LayoutBuilder(builder: (context, constraints) {
    SizeConfig.instance.init(constraints: constraints, screenHeight: 812, screenWidth: 375);

    return const MyApp();
  }));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    themeUtil.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Infinite Scroll Search',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: MaterialColor(
          appTheme.appColor.value,
          <int, Color>{
            50: appTheme.appColor,
            100: appTheme.appColor,
            200: appTheme.appColor,
            300: appTheme.appColor,
            400: appTheme.appColor,
            500: appTheme.appColor,
            600: appTheme.appColor,
            700: appTheme.appColor,
            800: appTheme.appColor,
            900: appTheme.appColor,
          },
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: Routes.PRODUCT,
      getPages: AppPages.pages,
    );
  }
}
