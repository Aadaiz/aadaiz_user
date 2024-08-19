import 'package:aadaiz/src/utils/routes/routes.dart';
import 'package:aadaiz/src/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {

  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes.generateRouteSettings,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        textSelectionTheme: const TextSelectionThemeData(
          selectionHandleColor: Colors.transparent
        ),
        splashColor: Colors.transparent,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      navigatorKey: navigatorKey,
      initialRoute: RoutesName.splashActivity
    );

  }

}