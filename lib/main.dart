import 'dart:developer';

import 'package:aadaiz_customer_crm/firebase_options.dart';
import 'package:aadaiz_customer_crm/src/res/Firebase/firebase.dart';
import 'package:aadaiz_customer_crm/src/services/app_bindings.dart';
import 'package:aadaiz_customer_crm/src/utils/routes/routes.dart';
import 'package:aadaiz_customer_crm/src/utils/routes/routes_name.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 Only initialize if not already initialized
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    log('Firebase already initialized: $e');
  }




  await FirebaseApi().initNotification();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp( DevicePreview(
      builder: (context) =>MyApp(navigatorKey: navigatorKey)));
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const MyApp({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          initialBinding: AppBindings(),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.generateRouteSettings,
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
            textSelectionTheme: const TextSelectionThemeData(
              selectionHandleColor: Colors.transparent,
            ),
            splashColor: Colors.transparent,
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          navigatorKey: navigatorKey,
          initialRoute: RoutesName.splashActivity,
        );
      },
    );
  }
}
