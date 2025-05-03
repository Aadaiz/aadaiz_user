import 'package:aadaiz_customer_crm/src/utils/routes/routes_name.dart';
import 'package:aadaiz_customer_crm/src/views/auth/ui/login.dart';
import 'package:aadaiz_customer_crm/src/views/auth/ui/otp_screen.dart';
import 'package:aadaiz_customer_crm/src/views/auth/ui/register_screen.dart';
import 'package:aadaiz_customer_crm/src/views/dashboard/splash_screen.dart';
import 'package:aadaiz_customer_crm/src/views/dashboard/welcome_screen.dart';
import 'package:flutter/material.dart';

class Routes{

  static Route<dynamic> generateRouteSettings(RouteSettings settings){

    switch(settings.name){

      case RoutesName.splashActivity:
        return MaterialPageRoute<SplashScreen>(
            builder: (BuildContext context) => const SplashScreen()
        );

      case RoutesName.welcomeActivity:
        return MaterialPageRoute<WelcomeScreen>(
            builder: (BuildContext context) => const WelcomeScreen()
        );

      case RoutesName.registerActivity:
        return MaterialPageRoute<RegisterScreen>(
            builder: (BuildContext context) => const RegisterScreen()
        );

      case RoutesName.otpAuthActivity:
        return MaterialPageRoute<OtpScreen>(
            builder: (BuildContext context) => OtpScreen()
        );

      case RoutesName.loginActivity:
        return MaterialPageRoute<Login>(
            builder: (BuildContext context) => const Login()
        );

      default:
        return MaterialPageRoute<Scaffold>(
            builder: (_){

              return const Scaffold(
                  body: Center(
                      child: Text(
                          'No route Found'
                      )
                  )
              );

            }
        );

    }

  }

}