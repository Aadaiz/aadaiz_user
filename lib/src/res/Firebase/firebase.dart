import 'dart:async';
import 'package:aadaiz_customer_crm/firebase_options.dart';
import 'package:aadaiz_customer_crm/main.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/screens/incoming_call.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';





/// =======================
/// BACKGROUND HANDLER
/// =======================
@pragma('vm:entry-point')
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await FirebaseNotificationHandler().handleMessage(message);
}

/// =======================
/// MAIN NOTIFICATION HANDLER
/// =======================
class FirebaseNotificationHandler {
  static final FirebaseNotificationHandler _instance =
  FirebaseNotificationHandler._internal();
  factory FirebaseNotificationHandler() => _instance;
  FirebaseNotificationHandler._internal();

  final FlutterLocalNotificationsPlugin _local =
  FlutterLocalNotificationsPlugin();

  /// Initialize local notifications & channels
  Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: androidInit);

    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: (resp) {
        if (resp.payload != null && resp.payload!.isNotEmpty) {
          final data = Uri.parse(resp.payload!).queryParameters;
          _navigateToIncomingCall(data);
        }
      },
    );

    // Full screen call channel
    const callChannel = AndroidNotificationChannel(
      'incoming_call_channel_id',
      'Incoming Calls',
      description: 'High priority incoming call notifications',
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
    );

    final androidPlugin = _local
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(callChannel);
  }

  /// Convert string payload → Map
  Map<String, String> _parsePayload(String payload) =>
      Uri.parse(payload).queryParameters;

  /// Handle all messages (foreground, background, terminated)
  Future<void> handleMessage(RemoteMessage message) async {
    final data = message.data;

    if (data['type'] == 'incoming_call') {
      await _showIncomingCallNotification(data);
    } else {
      await _showNormalNotification(
        title: data['title'] ?? message.notification?.title ?? "Notification",
        body: data['message'] ?? message.notification?.body ?? "",
      );
    }
  }

  /// Full screen incoming call notification
  Future<void> _showIncomingCallNotification(Map<String, dynamic> data) async {
    const android = AndroidNotificationDetails(
      'incoming_call_channel_id',
      'Incoming Calls',
      channelDescription: 'Incoming call notifications',
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true,
      autoCancel: false,
      ongoing: true,
      visibility: NotificationVisibility.public,
      ticker: 'Incoming call',
    );

    final payload = Uri(
      queryParameters: data.map((k, v) => MapEntry(k, v.toString())),
    ).toString();

    await _local.show(
      DateTime.now().millisecondsSinceEpoch % 100000,
      'Incoming Call',
      "${data['callerName'] ?? 'Someone'} is calling...",
      NotificationDetails(android: android),
      payload: payload,
    );
  }

  /// Normal notifications
  Future<void> _showNormalNotification({
    required String title,
    required String body,
  }) async {
    const android = AndroidNotificationDetails(
      'default_channel_id',
      'General Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    await _local.show(
      DateTime.now().millisecondsSinceEpoch % 100000,
      title,
      body,
      const NotificationDetails(android: android),
    );
  }

  /// Navigate to IncomingCallScreen
  void _navigateToIncomingCall(Map<String, String> data) {
    if (data['type'] != 'incoming_call') return;

    navigatorKey.currentState?.push(
      MaterialPageRoute(
        builder: (_) => IncomingCallScreen(
          callerName: data['callerName'] ?? 'Unknown',
          callId: data['id'],


          channelName: data['channelName'] ?? '',
          token: data['agoraToken'] ?? '',
          appId: "2db6113c15e748c696c5ac428edf2c0d",
        ),
      ),
    );
  }

  /// Auto-navigate for foreground calls
  void navigateDirectly(Map<String, dynamic> data) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (navigatorKey.currentState == null) {
        Future.delayed(const Duration(milliseconds: 500), () => navigateDirectly(data));
        return;
      }
      print("🟢 Navigator ready, opening IncomingCallScreen");
      navigatorKey.currentState!.push(
        MaterialPageRoute(
          builder: (_) => IncomingCallScreen(
            callerName: data['callerName'] ?? 'Unknown',
            callId: data['id'],

            channelName: data['channelName'] ?? '',
            token: data['agoraToken'] ?? '',
            appId: "2db6113c15e748c696c5ac428edf2c0d",
          ),
        ),
      );
    });
  }
}

/// =======================
/// FIREBASE API INTEGRATION
/// =======================
class FirebaseApi {
  final FirebaseNotificationHandler _handler = FirebaseNotificationHandler();

  Future<void> initNotification() async {
    final fcm = FirebaseMessaging.instance;

    // Request permissions
    await fcm.requestPermission(alert: true, badge: true, sound: true);

    // Get & save FCM token
    final token = await fcm.getToken();
    print("FCM TOKEN: $token");

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("fcm_token", token ?? "");

    // Init notification handler
    await _handler.init();

    // Background handler
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

    // Foreground handler
    FirebaseMessaging.onMessage.listen((msg) async {
      print("====== FOREGROUND FCM ======");
      print(msg.data);
      await _handler.handleMessage(msg);

      if (msg.data['type'] == 'incoming_call') {
        _handler.navigateDirectly(msg.data);
      }
    });

    // Terminated
    final initialMsg = await fcm.getInitialMessage();
    if (initialMsg != null && initialMsg.data['type'] == 'incoming_call') {
      _handler.navigateDirectly(initialMsg.data);
    }

    // Background → tap notification
    FirebaseMessaging.onMessageOpenedApp.listen((msg) {
      if (msg.data['type'] == 'incoming_call') {
        _handler.navigateDirectly(msg.data);
      }
    });
  }
}

