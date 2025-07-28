import 'package:aadaiz_customer_crm/src/res/Firebase/firebase.dart';
import 'package:aadaiz_customer_crm/src/utils/routes/routes.dart';
import 'package:aadaiz_customer_crm/src/utils/routes/routes_name.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'package:zego_zpns/zego_zpns.dart';

import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  await setupPushNotifications(); // Call here during app initialization

  /// 1.1.2: set navigator key to ZegoUIKitPrebuiltCallInvitationService
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);

  // call the useSystemCallingUI
  await ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI(
      [ZegoUIKitSignalingPlugin()],
    );

    runApp(MyApp(navigatorKey: navigatorKey));
  });
}


Future<void> setupPushNotifications() async {
  ZIMAppConfig appConfig = ZIMAppConfig(
  );
  appConfig.appID = 752441908; // Replace with your ZEGOCLOUD AppID
  appConfig.appSign =  "05518f2f576c1b4cbd8bd3df35ff4487477c45e89fc8f9654244442ba42551c0"; // Replace with your ZEGOCLOUD AppSign
  await ZIM.create(appConfig);
  await ZPNs.getInstance().registerPush(

  );
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
                    selectionHandleColor: Colors.transparent),
                splashColor: Colors.transparent,
                textTheme:
                    GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
                visualDensity: VisualDensity.adaptivePlatformDensity),
            navigatorKey: navigatorKey,
            initialRoute: RoutesName.splashActivity);
      },
    );
  }
}
