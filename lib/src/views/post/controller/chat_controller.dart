import 'dart:developer';

import 'package:aadaiz_customer_crm/src/views/post/socket_service/socket_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';











class PostChatController extends GetxController {
  final SocketService socketService = SocketService();
  final Dio _dio = Dio();

  var messages = <types.Message>[].obs;
  var isLoading = true.obs;

  final String currentUserId;
  final String conversationId;
  final String receiverId;
  final String token;

  static const String _baseUrl =
      "https://aadaizcrm.aadaiz.com/aadaiz-new/public/index.php/api";

  PostChatController({
    required this.currentUserId,
    required this.conversationId,
    required this.receiverId,
    required this.token,
  });

  @override
  void onInit() {
    super.onInit();
    _fetchMessages();
    socketService.connect();
    socketService.joinRoom(conversationId: conversationId, token: token);
    _listenSocketEvents();
  }

  // ─────────────────────────────────────────
  // 📥 Fetch message history from Laravel API
  // ─────────────────────────────────────────
  Future<void> _fetchMessages() async {
    try {
      isLoading.value = true;

      final response = await _dio.get(
        "$_baseUrl/post/messages/$conversationId",
        options: Options(
          headers: {"Authorization": "Bearer $token"},
        ),
      );

      final body = response.data;

      if (body['status'] == true) {
        final List list = body['data'] ?? [];

        final loaded = list
            .where((e) =>
        e['message'] != null &&
            (e['message'] as String).trim().isNotEmpty)
            .map<types.TextMessage>((e) {
          return types.TextMessage(
            id: e['id'].toString(),
            author: types.User(
              id: e['sender_id'].toString(),
            ),
            text: e['message'] as String,
            createdAt:
            DateTime.parse(e['created_at']).millisecondsSinceEpoch,
          );
        }).toList();

        // API: oldest→newest | Chat UI: newest→oldest
        messages.value = loaded.reversed.toList();
      }
    } catch (e) {
      log("❌ Fetch messages error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // ─────────────────────────────────────────
  // 🔌 Socket listeners
  // ─────────────────────────────────────────
  void _listenSocketEvents() {
    // Fallback: only used if REST fetch failed
    socketService.socket.on("message_list", (data) {
      if (messages.isNotEmpty) return;

      final List list = data['data'] ?? [];
      final loaded = list
          .where((e) =>
      e['message'] != null &&
          (e['message'] as String).trim().isNotEmpty)
          .map<types.TextMessage>((e) {
        return types.TextMessage(
          id: e['id'].toString(),
          author: types.User(id: e['sender_id'].toString()),
          text: e['message'] as String,
          createdAt: DateTime.parse(e['created_at']).millisecondsSinceEpoch,
        );
      }).toList();

      messages.value = loaded.reversed.toList();
    });

    // 🔥 Realtime incoming message
    socketService.socket.on("receive_message", (data) {
      final senderId = data['sender_id']?.toString().trim() ?? "";
      final text = data['message']?.toString().trim() ?? "";
      final msgId = data['id']?.toString();

      if (text.isEmpty || msgId == null) return;

      // ✅ IMPORTANT: skip if already exists
      final alreadyExists = messages.any((m) => m.id == msgId);
      if (alreadyExists) return;

      final msg = types.TextMessage(
        id: msgId,
        author: types.User(id: senderId),
        text: text,
        createdAt: DateTime.parse(data['created_at']).millisecondsSinceEpoch,
      );

      messages.insert(0, msg);
    });


    socketService.socket.on("typing", (data) {
      // TODO: show typing indicator
    });

    socketService.socket.on("chat_list_update", (data) {
      // TODO: refresh chat list screen
    });
  }

  // ─────────────────────────────────────────
  // ✉ Send message
  // ─────────────────────────────────────────
  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final tempId = const Uuid().v4();



    messages.insert(
      0,
      types.TextMessage(
        id: tempId,
        author: types.User(id: currentUserId),
        text: text,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    socketService.sendMessage(
      conversationId: conversationId,
      receiverId: receiverId,
      senderId: currentUserId,
      message: text,
      token: token,
      tempId: tempId, // ✅ ADD THIS
    );
  }

  // 📎 Send file
  void sendFile(String fileUrl) {
    final tempId = const Uuid().v4();

    messages.insert(
      0,
      types.TextMessage(
        id: tempId,
        author: types.User(id: currentUserId),
        text: "[File]",
        createdAt: DateTime.now().millisecondsSinceEpoch,
      ),
    );

    socketService.sendMessage(
      conversationId: conversationId,
      receiverId: receiverId,
      senderId: currentUserId,
      file: fileUrl,
      token: token,
    );
  }

  @override
  void onClose() {
    socketService.dispose();
    super.onClose();
  }
}