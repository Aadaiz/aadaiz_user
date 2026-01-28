import 'dart:async';
import 'dart:developer';
import 'package:aadaiz_customer_crm/main.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/controller/call_controller.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/screens/incoming_call.dart';
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

  /// Initialize local notifications
  Future<void> init() async {
    const AndroidInitializationSettings androidInit =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInit =
    DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _local.initialize(
      settings,
      onDidReceiveNotificationResponse: (resp) {
        if (resp.payload != null && resp.payload!.isNotEmpty) {
          final data = _parsePayload(resp.payload!);
          _navigateToIncomingCall(data);
        }
      },
    );

    const AndroidNotificationChannel callChannel =
    AndroidNotificationChannel(
      'incoming_call_channel_id',
      'Incoming Calls',
      description: 'High priority incoming call notifications',
      importance: Importance.max,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('incoming_call'),
      enableVibration: true,
    );

    final androidPlugin = _local
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(callChannel);

    log("User App: Local notifications initialized");
  }

  /// Convert payload string → Map
  Map<String, String> _parsePayload(String payload) {
    try {
      return Uri.parse(payload).queryParameters;
    } catch (e) {
      log("Payload parse error: $e");
      return {};
    }
  }

  /// Handle messages
  Future<void> handleMessage(RemoteMessage message) async {
    final data = message.data;
    final notification = message.notification;

    final String type = data['type'] ?? 'normal';

    final String title =
        data['title'] ?? notification?.title ?? 'Notification';

    final String body =
        data['message'] ?? notification?.body ?? '';

    log("User App Message Type: $type");

    if (type == 'incoming_call') {
      await _showIncomingCallNotification(data);
    } else {
      await _showNormalNotification(title: title, body: body);
    }
  }

  /// Incoming call notification (full screen)
  Future<void> _showIncomingCallNotification(
      Map<String, dynamic> data) async {
    try {
      final payload = Uri(
        queryParameters:
        data.map((k, v) => MapEntry(k, v.toString())),
      ).toString();

      const AndroidNotificationDetails android =
      AndroidNotificationDetails(
        'incoming_call_channel_id',
        'Incoming Calls',
        channelDescription: 'Incoming call notifications',
        importance: Importance.max,
        priority: Priority.high,
        fullScreenIntent: true,
        autoCancel: false,
        ongoing: true,
        visibility: NotificationVisibility.public,
        category: AndroidNotificationCategory.call,
        timeoutAfter: 45000,
      );

      const DarwinNotificationDetails ios =
      DarwinNotificationDetails(
        presentAlert: true,
        presentSound: true,
        presentBadge: true,
        interruptionLevel: InterruptionLevel.critical,
      );

      await _local.show(
        DateTime.now().millisecondsSinceEpoch % 100000,
        'Incoming Call',
        '${data['callerName'] ?? 'Someone'} is calling...',
        const NotificationDetails(android: android, iOS: ios),
        payload: payload,
      );

      log("User App: Incoming call notification shown");
    } catch (e) {
      log("User App: Notification error $e");
    }
  }

  /// Normal notifications
  Future<void> _showNormalNotification({
    required String title,
    required String body,
  }) async {
    const AndroidNotificationDetails android =
    AndroidNotificationDetails(
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

  /// Navigate to incoming call screen (SAFE)
  void _navigateToIncomingCall(Map<String, String> data) {
    try {
      final callCon = Get.find<CallStateController>();
      final callId = data['id'] ?? '';

      if (callCon.isCallActive.value) {
        log("User App: Call already active, ignored");
        return;
      }

      callCon.setIncoming(callId);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (navigatorKey.currentContext != null) {
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (_) => IncomingCallScreen(
                callerName: data['callerName'] ?? 'Unknown',
                callId: callId,
                channelName: data['channelName'] ?? '',
                token: data['agoraToken'] ?? '',
                appId: "2db6113c15e748c696c5ac428edf2c0d",
              ),
            ),
          );
          log("User App: Navigated to IncomingCallScreen");
        } else {
          log("User App: navigatorKey context null");
        }
      });
    } catch (e) {
      log("Navigation error: $e");
    }
  }

  /// Direct navigation (foreground / retry safe)
  void navigateDirectly(Map<String, dynamic> data) {
    _navigateToIncomingCall(
      data.map((k, v) => MapEntry(k, v.toString())),
    );
  }
}

/// =======================
/// FIREBASE API
/// =======================
class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  final FirebaseNotificationHandler _handler =
  FirebaseNotificationHandler();

  Future<void> initNotification() async {
    try {
      log("User App: Initializing Firebase notifications");

      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      final token = await _firebaseMessaging.getToken();
      log("User App FCM Token: $token");

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("fcm_token", token ?? "");

      await _handler.init();

      FirebaseMessaging.onBackgroundMessage(
        firebaseBackgroundHandler,
      );

      FirebaseMessaging.onMessage.listen((msg) async {
        log("User App: Foreground message received");
        await _handler.handleMessage(msg);

        if (msg.data['type'] == 'incoming_call') {
          Future.delayed(Duration.zero, () {
            _handler.navigateDirectly(msg.data);
          });
        }
      });

      final initialMsg =
      await _firebaseMessaging.getInitialMessage();
      if (initialMsg != null &&
          initialMsg.data['type'] == 'incoming_call') {
        log("User App: Terminated → opening call");
        _handler.navigateDirectly(initialMsg.data);
      }

      FirebaseMessaging.onMessageOpenedApp.listen((msg) {
        if (msg.data['type'] == 'incoming_call') {
          log("User App: Background tap → opening call");
          _handler.navigateDirectly(msg.data);
        }
      });

      log("User App: Firebase notifications initialized");
    } catch (e) {
      log("User App Firebase init error: $e");
    }
  }
}

