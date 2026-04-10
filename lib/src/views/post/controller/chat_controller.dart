import 'dart:developer';

import 'package:aadaiz_customer_crm/src/services/api_service.dart';
import 'package:aadaiz_customer_crm/src/views/post/socket_service/socket_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class PostChatController extends GetxController {
  final SocketService socketService = SocketService();
  final Dio _dio = Dio();

  // ✅ typed as CustomMessage throughout
  var messages = <types.CustomMessage>[].obs;
  var isLoading = true.obs;

  final String currentUserId;
  final String conversationId;
  final String receiverId;
  final String token;

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
  // 📥 Fetch messages from REST
  // ─────────────────────────────────────────
  Future<void> _fetchMessages() async {
    try {
      isLoading.value = true;

      final response = await _dio.get(
        "${Api.conversationData}/$conversationId",
        options: Options(headers: {"Authorization": "Bearer $token"}),
      );

      final body = response.data;

      if (body['status'] == true) {
        final List list = body['data'] ?? [];

        final loaded = list
            .where((e) =>
        e['message'] != null &&
            (e['message'] as String).trim().isNotEmpty)
            .map<types.CustomMessage>((e) => _buildCustomMessage(
          id: e['id'].toString(),
          senderId: e['sender_id'].toString(),
          text: e['message'],
          createdAt: DateTime.parse(e['created_at']),
          postId: e['post_id'],
          postUserName: e['post_user_name'],
          postUserProfile: e['post_user_profile'],
          postCaption: e['post_caption'],
        ))
            .toList();

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
          .map<types.CustomMessage>((e) => _buildCustomMessage(
        id: e['id'].toString(),
        senderId: e['sender_id'].toString(),
        text: e['message'],
        createdAt: DateTime.parse(e['created_at']),
      ))
          .toList();

      messages.value = loaded.reversed.toList();
    });

    // 🔥 Realtime incoming message
    socketService.socket.on("receive_message", (data) {
      final senderId = data['sender_id']?.toString().trim() ?? "";
      final text = data['message']?.toString().trim() ?? "";
      final msgId = data['id']?.toString();

      if (text.isEmpty || msgId == null) return;

      // ✅ Skip if already exists (dedup with tempId)
      final alreadyExists = messages.any((m) => m.id == msgId);
      if (alreadyExists) return;

      // ✅ Replace temp message sent by me, or insert new one
      final tempIndex = messages.indexWhere(
            (m) => m.metadata?['temp'] == true && m.author.id == senderId,
      );

      final incoming = _buildCustomMessage(
        id: msgId,
        senderId: senderId,
        text: text,
        createdAt: DateTime.parse(data['created_at']),
        postId: data['post_id'],
        postUserName: data['post_user_name'],
        postUserProfile: data['post_user_profile'],
        postCaption: data['post_caption'],
      );

      if (tempIndex != -1 && senderId == currentUserId) {
        messages[tempIndex] = incoming;
      } else {
        messages.insert(0, incoming);
      }
    });

    socketService.socket.on("typing", (data) {
      // TODO: show typing indicator
    });

    socketService.socket.on("chat_list_update", (data) {
      // TODO: refresh chat list screen
    });
  }

  // ─────────────────────────────────────────
  // ✉ Send text message
  // ─────────────────────────────────────────
  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    final tempId = const Uuid().v4();

    // ✅ Insert as CustomMessage with temp flag
    messages.insert(
      0,
      _buildCustomMessage(
        id: tempId,
        senderId: currentUserId,
        text: text,
        createdAt: DateTime.now(),
        isTemp: true,
      ),
    );

    socketService.sendMessage(
      conversationId: conversationId,
      receiverId: receiverId,
      senderId: currentUserId,
      message: text,
      token: token,
      tempId: tempId,
    );
  }

  // ─────────────────────────────────────────
  // 📎 Send file
  // ─────────────────────────────────────────
  void sendFile(String fileUrl) {
    final tempId = const Uuid().v4();

    messages.insert(
      0,
      _buildCustomMessage(
        id: tempId,
        senderId: currentUserId,
        text: fileUrl,
        createdAt: DateTime.now(),
        isTemp: true,
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

  // ─────────────────────────────────────────
  // 🏗 Central factory — always CustomMessage
  // ─────────────────────────────────────────
  types.CustomMessage _buildCustomMessage({
    required String id,
    required String senderId,
    required String text,
    required DateTime createdAt,
    dynamic postId,
    String? postUserName,
    String? postUserProfile,
    String? postCaption,
    bool isTemp = false,
  }) {
    return types.CustomMessage(
      id: id,
      author: types.User(id: senderId),
      createdAt: createdAt.millisecondsSinceEpoch,
      metadata: {
        'text': text,
        if (postId != null) 'post_id': postId,
        if (postUserName != null) 'post_user_name': postUserName,
        if (postUserProfile != null) 'post_user_profile': postUserProfile,
        if (postCaption != null) 'post_caption': postCaption,
        if (isTemp) 'temp': true,
      },
    );
  }

  @override
  void onClose() {
    socketService.dispose();
    super.onClose();
  }
}
