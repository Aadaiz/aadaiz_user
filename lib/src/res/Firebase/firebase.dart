// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   print("title :${message.notification?.title}");
//   print("body :${message.notification?.body}");
//   print("token :${message.data}");
// }

// class FirebaseApi {
//   final _firebasemessaging = FirebaseMessaging.instance;

//   Future<void> initNotification() async {
//     // Request permission to receive notifications
//     await _firebasemessaging.requestPermission();

//     // Get the Firebase Cloud Messaging token
//     final fCMToken = await _firebasemessaging.getToken();
//     print("tokensda :$fCMToken");
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString("fcm_token", fCMToken??'');
//       String? fcmToken=   prefs.getString("fcm_token");
//    print("gettokensda :$fcmToken");

//     // Handle background notifications
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

//     // Handle foreground notifications
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       print("Foreground message received: ${message.notification?.title}");
//       print("Body: ${message.notification?.body}");

//       // Show a local notification or handle it as needed
//     });
//   }
// }
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title: ${message.notification?.title}");
  print("Body: ${message.notification?.body}");
  print("Data: ${message.data}");
}

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    // Request permission to receive notifications
    await _firebaseMessaging.requestPermission();

    // Get the Firebase Cloud Messaging token
    final fCMToken = await _firebaseMessaging.getToken();
    print("FCM Token: $fCMToken");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("fcm_token", fCMToken ?? '');
    String? savedToken = prefs.getString("fcm_token");
    print("Saved FCM Token: $savedToken");

    // Initialize local notifications
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: androidSettings);
    await _localNotificationsPlugin.initialize(initializationSettings);

    // Handle background notifications
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    // Handle foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message received: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");

      // Show a local notification
      _showNotification(
        message.notification?.title ?? 'No Title',
        message.notification?.body ?? 'No Body',
      );
    });
  }

  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails platformDetails = NotificationDetails(android: androidDetails);

    await _localNotificationsPlugin.show(
      0, // Notification ID
      title,
      body,
      platformDetails,
    );
  }
}
