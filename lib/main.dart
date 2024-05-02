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
import 'package:finpay/presentation/view/tab_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get.dart';

import 'config/services/local/awesomeNotificationService.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundNotification(RemoteMessage msg) async {
  print('ttttttttt ${msg.notification!.body}');
}

void main() async {
  late Widget home;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  configurationDependencies();

  await CacheHelper.init();
  bool skipped = CacheHelper.getData(key: 'skipped') ?? false;
  language = await CacheHelper.getData(key: 'lang') ?? 'en';
  final user = await CacheHelper.getSecureData(key: 'user');
  final ThemeData theme = await AppTheme.getTheme();
  if (user != null) {
    currentUser = UserModel.fromJson(
      json.decode(
        user,
      ),
    );
    if (currentUser.pinCodeRequired == 0) {
      home = const TabScreen();
    } else {
      home = const VerifyPinScreen();
    }
  } else if (skipped) {
    home = const LoginScreen();
  } else {
    home = const SplashScreen();
  }

  await Firebase.initializeApp();
  /* final notificationSettings = await FirebaseMessaging.instance
      .requestPermission(provisional: true, criticalAlert: true);
  if (notificationSettings.authorizationStatus ==
      AuthorizationStatus.authorized) */
   enabled = await CacheHelper.getData(key: 'notification');
   //null or true
  if (enabled??true) {
    bool initialized = await locators.get<AwesomeNotificationService>().init();
    if (initialized) {
      fcmToken = await FirebaseMessaging.instance.getToken();

      FirebaseMessaging.onMessage.listen((data) {
        locators.get<AwesomeNotificationService>().showNotification(
              title: data.notification!.title!,
              body: data.notification!.body!,
            );
      });

      FirebaseMessaging.onBackgroundMessage(handleBackgroundNotification);
    }
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (_) => runApp(
      MyApp(home: home, theme: theme),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Widget home;
  final ThemeData theme;
  const MyApp({Key? key, required this.home, required this.theme})
      : super(key: key);

  static setCustomeTheme(BuildContext context, int index) async {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();

    state!.setCustomeTheme(index);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeData theme;

  setCustomeTheme(int index) {
    if (index == 6) {
      setState(() {
        theme = AppTheme.lightTheme();
        AppTheme.isLightTheme = true;
      });
    } else if (index == 7) {
      setState(() {
        theme = AppTheme.darkTheme();

        AppTheme.isLightTheme = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = widget.theme;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: widget.theme.primaryColor,
      systemNavigationBarDividerColor: widget.theme.disabledColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return GetMaterialApp(
      title: 'Pay To Me',
      theme: theme,
      debugShowCheckedModeBanner: false,
      locale: Locale(language),
      home: Builder(builder: (context) {
        return widget.home;
      }),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
