import 'dart:convert';
import 'dart:developer';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/Repository/chat_repo.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/model/chatList_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatview/chatview.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ChatMessageController extends GetxController {
  late ChatController chatController;
  RxList<Message> messages = <Message>[].obs;

  String? currentUserId;
  String? customerId;
  String? currentUserType;

  /// Initialize with user type
  void initializeController({
    required String currentUserId,
    required String customerId,
    required String currentUserType,
  }) {
    this.currentUserId = currentUserId;
    this.customerId = customerId;
    this.currentUserType = currentUserType;

    debugPrint('🎯 INITIALIZE CHAT CONTROLLER:');
    debugPrint('   → Current User ID: $currentUserId');
    debugPrint('   → Customer ID: $customerId');
    debugPrint('   → Current User Type: $currentUserType');

    chatController = ChatController(
      initialMessageList: messages,
      scrollController: ScrollController(),
      currentUser: ChatUser(id: currentUserId, name: ''),
      otherUsers: [ChatUser(id: customerId, name: '')],
    );
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getChatList();
  }
  /// Clear all messages safely
  void clearMessages() {
    debugPrint('🧹 CLEARING ALL MESSAGES');
    messages.clear();
    chatController.initialMessageList.clear();
  }

  /// Add a new message with proper alignment
  void addMessage(Map<String, dynamic> json) {
    debugPrint('\n📨 NEW MESSAGE RECEIVED:');
    debugPrint('   → Raw JSON: $json');

    final String senderType =
        json["sender_type"]?.toString().toLowerCase() ?? "unknown";
    final String messageText = json["message"]?.toString() ?? "";
    final String createdAt = json["created_at"]?.toString() ?? "";
    final String senderIdFromApi = json["sender_id"]?.toString() ?? "unknown";

    debugPrint('   → Sender Type from API: $senderType');
    debugPrint('   → Sender ID from API: $senderIdFromApi');
    debugPrint('   → Message: $messageText');
    debugPrint('   → Created At: $createdAt');

    // Log current controller state
    debugPrint('   → Controller Current User ID: $currentUserId');
    debugPrint('   → Controller Customer ID: $customerId');
    debugPrint('   → Controller Current User Type: $currentUserType');

    // Determine the actual sender ID based on sender_type
    String messageSenderId;
    if (senderType == "customer") {
      messageSenderId = customerId ?? "customer";
      debugPrint('   → Identified as CUSTOMER message');
    } else if (senderType == "admin") {
      messageSenderId = currentUserId ?? "admin"; // This might be the issue!
      debugPrint('   → Identified as ADMIN message');
    } else {
      messageSenderId = "unknown";
      debugPrint('   → ❌ UNKNOWN SENDER TYPE');
    }

    // Determine if this message was sent by the current user
    final bool isSentByMe = (senderType == currentUserType?.toLowerCase());

    debugPrint('   → Current User Type: $currentUserType');
    debugPrint('   → Is Sent By Me: $isSentByMe');
    debugPrint(
      '   → Final Sender ID: ${isSentByMe ? currentUserId! : messageSenderId}',
    );
    debugPrint(
      '   → Message Alignment: ${isSentByMe ? "RIGHT (my message)" : "LEFT (their message)"}',
    );

    // **ADD THIS CRITICAL CHECK**
    debugPrint(
      '   → API sender_id ($senderIdFromApi) vs Current User ID ($currentUserId) = ${senderIdFromApi == currentUserId}',
    );

    // **FIX: Use the actual sender_id from API for more accurate detection**
    final bool isActuallySentByMe = senderIdFromApi == currentUserId;
    debugPrint(
      '   → ACTUAL Is Sent By Me (based on sender_id): $isActuallySentByMe',
    );

    final String finalSenderId;
    if (isActuallySentByMe) {
      finalSenderId = currentUserId!;
      debugPrint('   → USING Current User ID as sender');
    } else {
      finalSenderId = senderIdFromApi;
      debugPrint('   → USING API sender_id as sender');
    }

    final msg = Message(
      id:
      json["id"]?.toString() ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
      message: messageText,
      sentBy: finalSenderId, // Use the corrected sender ID
      messageType: json["file_path"] != null
          ? MessageType.image
          : MessageType.text,
    );

    messages.add(msg);
    messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    chatController.addMessage(msg);

    debugPrint('   → Total messages in list: ${messages.length}');
    debugPrint('   → Last message sentBy: ${messages.last.sentBy}');

    // Print the actual message object being added
    debugPrint(
      '   → Message Object: id: ${msg.id}, sentBy: ${msg.sentBy}, message: ${msg.message}',
    );
  }

  /// Log when sending a message
  void logMessageSending({
    required String message,
    required String senderType,
    required String orderId,
  }) {
    debugPrint('\n📤 SENDING MESSAGE:');
    debugPrint('   → Message: $message');
    debugPrint('   → Sender Type: $senderType');
    debugPrint('   → Order ID: $orderId');
    debugPrint('   → Current User ID: $currentUserId');
    debugPrint('   → Current User Type: $currentUserType');
    debugPrint('   → Expected Alignment: RIGHT (my message)');
  }

  /// Dispose ChatController to avoid GlobalKey conflicts
  void disposeController() {
    debugPrint('🔚 DISPOSING CHAT CONTROLLER');
    chatController.dispose();
  }

  /// Debug method to print current state
  void printCurrentState() {
    debugPrint('\n🔍 CURRENT CHAT STATE:');
    debugPrint('   → Current User ID: $currentUserId');
    debugPrint('   → Customer ID: $customerId');
    debugPrint('   → Current User Type: $currentUserType');
    debugPrint('   → Total Messages: ${messages.length}');

    for (int i = 0; i < messages.length; i++) {
      final msg = messages[i];
      debugPrint(
        '   → Message $i: "${msg.message}" | sentBy: ${msg.sentBy} | isMyMessage: ${msg.sentBy == currentUserId}',
      );
    }
  }

  var isLoading = false.obs;
  ChatRepository repo = ChatRepository();
  Future callOthers(
      String myName,
      String myId,

      String orderId
      ) async {
    try {
      isLoading.value = true;
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString("token");
      final Map<String, dynamic> request = {
        'token':token,
        "type": "incoming_call",
        "callerName": myName,
        "callerId": myId,

        'order_id':orderId
      };
      final res = await repo.callOthers(jsonEncode(request));
      final data = jsonDecode(res);
      if (data['status'] == true) {   return data['data'];}else{
        return null;
      }
    } finally {
      isLoading.value = false;
    }
  }

  var chatListData = <Datum>[].obs;
  Future<void> getChatList() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString("token");

      final Map<String, String> headers = {'token': '$token'};

      final ChatList res = await repo.getChatList(headers);
      if (res.status == true) {
        chatListData.value = res.data!;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
