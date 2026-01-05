import 'package:aadaiz_customer_crm/src/res/Firebase/firebase.dart';
import 'package:aadaiz_customer_crm/src/utils/routes/routes.dart';
import 'package:aadaiz_customer_crm/src/utils/routes/routes_name.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/controller/ChatMessageController.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/controller/ChatSocketController.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/controller/call_controller.dart';
import 'package:aadaiz_customer_crm/src/views/profile/controller/profile_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'firebase_options.dart';

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
    print('Firebase already initialized: $e');
  }

  // 🔹 Register controllers
  Get.put(ChatSocketController(), permanent: true);
  Get.put(ChatMessageController(), permanent: true);
  Get.put(ProfileController(), permanent: true);
  Get.put(CallStateController(), permanent: true);

  // 🔹 Only initialize FCM after Firebase is fully ready
  await FirebaseApi().initNotification();

  runApp(MyApp(navigatorKey: navigatorKey));
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
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.generateRouteSettings,
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
            textSelectionTheme: const TextSelectionThemeData(
              selectionHandleColor: Colors.transparent,
            ),
            splashColor: Colors.transparent,
            textTheme:
            GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          navigatorKey: navigatorKey,
          initialRoute: RoutesName.splashActivity,
        );
      },
    );
  }
}
