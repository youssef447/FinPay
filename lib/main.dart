// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';

import 'package:finpay/config/injection.dart';
import 'package:finpay/config/services/local/cach_helper.dart';
import 'package:finpay/core/style/textstyle.dart';
import 'package:finpay/core/utils/globales.dart';
import 'package:finpay/data/models/user_model.dart';
import 'package:finpay/presentation/view/login/login_screen.dart';
import 'package:finpay/presentation/view/login/pin_screen.dart';
import 'package:finpay/presentation/view/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';


void main() async {
  late Widget home;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark
      
      
    ),
  );
  configurationDependencies();

  await CacheHelper.init();
  bool skipped = CacheHelper.getData(key: 'skipped') ?? false;
  language = await CacheHelper.getData(key: 'lang')??'en';
  final user = await CacheHelper.getSecureData(key: 'user');
  if (user != null) {
    currentUser = UserModel.fromJson(
      json.decode(
        user,
      ),
    );
    home = const VerifyPinScreen();
  } else if (skipped) {
    home = const LoginScreen();
  } else {
    home = const SplashScreen();
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
      MyApp(home: home),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Widget home;
  const MyApp({Key? key, required this.home}) : super(key: key);

  static setCustomeTheme(BuildContext context, int index) async {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();

    state!.setCustomeTheme(index);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  setCustomeTheme(int index) {
    if (index == 6) {
      setState(() {
        AppTheme.isLightTheme = true;
      });
    } else if (index == 7) {
      setState(() {
        AppTheme.isLightTheme = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppTheme.getTheme().primaryColor,
      systemNavigationBarDividerColor: AppTheme.getTheme().disabledColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return 
      GetMaterialApp(
        title: 'FinPay',
        theme: AppTheme.getTheme(),
        debugShowCheckedModeBanner: false,
        locale:Locale(language),
        home: Builder(builder: (context) {
          return widget.home;
        }),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
      
    );
  }
}
