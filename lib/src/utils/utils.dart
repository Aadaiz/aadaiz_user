import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils{

  static double getActivityScreenWidth(BuildContext context){

    return MediaQuery.of(context).size.width;

  }

  static double getActivityScreenHeight(BuildContext context){

    return MediaQuery.of(context).size.height;

  }

  static void fieldFocusChange({required BuildContext context, required FocusNode currentFocus, required FocusNode nextFocus}){

    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);

  }

}


