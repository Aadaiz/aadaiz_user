import 'package:aadaiz_customer_crm/src/views/post/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';

class CustomChatTheme extends DefaultChatTheme {
  const CustomChatTheme({required super.primaryColor});

  @override
  Color get backgroundColor => Colors.grey[100]!;

  @override
  BorderRadius get inputBorderRadius => BorderRadius.circular(28);

  @override
  EdgeInsets get inputMargin => const EdgeInsets.symmetric(horizontal: 12, vertical: 8);

  @override
  EdgeInsets get inputPadding => const EdgeInsets.symmetric(horizontal: 20, vertical: 12);

  @override
  Color get inputBackgroundColor => Colors.white;

  @override
  Color get inputSurfaceTintColor => Colors.white;

  @override
  double get inputElevation => 2;

  @override
  Decoration? get inputContainerDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(5),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.15),
        blurRadius: 8,
        offset: const Offset(0, -2),
      ),
    ],
  );

  @override
  TextStyle get inputTextStyle => const TextStyle(fontSize: 16, color: Colors.black87);

  @override
  Color get inputTextColor => Colors.black87;

  @override
  Widget? get sendButtonIcon => Icon(Icons.send_rounded, color: primaryColor, size: 24);

  @override
  double get messageInsetsHorizontal => 16.0;

  @override
  double get messageInsetsVertical => 12.0;

  @override
  double get messageBorderRadius => 20.0;

  @override
  TextStyle get sentMessageBodyTextStyle => const TextStyle(color: Colors.white, fontSize: 15);

  @override
  TextStyle get receivedMessageBodyTextStyle => const TextStyle(color: Colors.black87, fontSize: 15);

  @override
  Color get secondaryColor => Colors.white;

  Decoration get sentMessageDecoration => BoxDecoration(
    color: primaryColor,
    borderRadius: BorderRadius.circular(20),
  );

  Decoration get receivedMessageDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
    ],
  );
}

class PostChatScreen extends StatefulWidget {
  final String conversationId;
  final String receiverId;
  final String token;
  final String currentUserId;
  final String profileName;
  final String profileImage;

  const PostChatScreen({
    super.key,
    required this.conversationId,
    required this.receiverId,
    required this.token,
    required this.currentUserId,
    required this.profileName,
    required this.profileImage,
  });

  @override
  State<PostChatScreen> createState() => _PostChatScreenState();
}

class _PostChatScreenState extends State<PostChatScreen> {
  late PostChatController controller;
  static const primaryColor = Color(0xFF0C1855);

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      PostChatController(
        currentUserId: widget.currentUserId,
        conversationId: widget.conversationId,
        receiverId: widget.receiverId,
        token: widget.token,
      ),
      tag: widget.conversationId,
    );
  }

  @override
  void dispose() {
    Get.delete<PostChatController>(tag: widget.conversationId);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: widget.profileImage.isNotEmpty ? NetworkImage(widget.profileImage) : null,
              radius: 16,
              child: widget.profileImage.isEmpty && widget.profileName.isNotEmpty
                  ? Text(widget.profileName[0])
                  : null,
            ),
            const SizedBox(width: 12),
            Text(widget.profileName, style: const TextStyle(fontWeight: FontWeight.w600)),
          ],
        ),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
            ),
          );
        }

        return Chat(
          messages: List.from(controller.messages),
          user: types.User(id: widget.currentUserId),
          onSendPressed: (partialText) => controller.sendMessage(partialText.text),
          theme: const CustomChatTheme(primaryColor: primaryColor),
          emptyState: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.chat_bubble_outline_rounded, size: 64, color: primaryColor.withOpacity(0.4)),
                const SizedBox(height: 16),
                Text(
                  'No messages yet.\nSay hi! 👋',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}