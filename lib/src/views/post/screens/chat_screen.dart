import 'package:aadaiz_customer_crm/src/views/post/controller/chat_controller.dart';
import 'package:aadaiz_customer_crm/src/views/post/screens/post_view_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:get/get.dart';


class CustomChatTheme extends DefaultChatTheme {
  const CustomChatTheme({required super.primaryColor});

  @override
  Color get backgroundColor => const Color(0xFFF8F9FB);

  @override
  BorderRadius get inputBorderRadius => BorderRadius.circular(28);

  @override
  EdgeInsets get inputMargin => EdgeInsets.zero;

  @override
  EdgeInsets get inputPadding =>
      const EdgeInsets.symmetric(horizontal: 16, vertical: 10);

  @override
  Color get inputBackgroundColor => const Color(0xFFF0F2F5);

  @override
  Color get inputSurfaceTintColor => const Color(0xFFF0F2F5);

  @override
  double get inputElevation => 0;

  @override
  Decoration? get inputContainerDecoration => const BoxDecoration(
    color:  Color(0xFFF0F2F5),
    border: Border(
      top: BorderSide(color: Color(0x0F000000), width: 0.8),
    ),
  );

  @override
  TextStyle get inputTextStyle =>
      const TextStyle(fontSize: 15, color: Color(0xFF1A1A2E), height: 1.4);

  @override
  Color get inputTextColor => const Color(0xFF1A1A2E);

  @override
  Widget? get sendButtonIcon => Container(
    width: 40,
    height: 40,
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF0C1855), Color(0xFF1E3A8A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF0C1855).withOpacity(0.35),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: const Icon(Icons.send_rounded, color: Colors.white, size: 18),
  );

  @override
  double get messageInsetsHorizontal => 14;

  @override
  double get messageInsetsVertical => 10;

  @override
  double get messageBorderRadius => 20;

  @override
  TextStyle get sentMessageBodyTextStyle => const TextStyle(
    color: Colors.white,
    fontSize: 15,
    height: 1.45,
  );

  @override
  TextStyle get receivedMessageBodyTextStyle => const TextStyle(
    color: Color(0xFF1A1A2E),
    fontSize: 15,
    height: 1.45,
  );

  @override
  Color get secondaryColor =>  const Color(0xFFF8F9FB);

  @override
  Decoration get sentMessageDecoration => BoxDecoration(
    gradient: const LinearGradient(
      colors: [Color(0xFF0C1855), Color(0xFF1E3A8A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
      bottomLeft: Radius.circular(20),
      bottomRight: Radius.circular(6),
    ),
    boxShadow: [
      BoxShadow(
        color: const Color(0xFF0C1855).withAlpha(10),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ],
  );

  @override
  Decoration get receivedMessageDecoration => BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
      bottomLeft: Radius.circular(6),
      bottomRight: Radius.circular(20),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.07),
        blurRadius: 4,
        offset: const Offset(0, 1),
      ),
    ],
  );

  @override
  TextStyle get dateDividerTextStyle => const TextStyle(
    color: Color(0xFFAAAAAA),
    fontSize: 11.5,
    fontWeight: FontWeight.w500,
  );

  @override
  Widget get dateDividerBuilder => const SizedBox.shrink();
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

  static const Color _primary = Color(0xFF0C1855);
  static const Color _primaryLight = Color(0xFF1E3A8A);
  static const Gradient _primaryGradient = LinearGradient(
    colors: [_primary, _primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

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

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0C1855), Color(0xFF1A2F7A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
          titleSpacing: 0,
          title: Row(
            children: [

              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white24,
                      backgroundImage: widget.profileImage.isNotEmpty
                          ? NetworkImage(widget.profileImage)
                          : null,
                      child: widget.profileImage.isEmpty
                          ? Text(
                        widget.profileName[0].toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      )
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4ADE80),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF0C1855),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              // Name + status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.profileName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const Text(
                    'Active now',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white60,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ],
          ),

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: _buildAppBar(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: _primary,
              strokeWidth: 2.5,
            ),
          );
        }

        return // In PostChatScreen — fix the theme primaryColor and list cast
          Chat(
            messages: List<types.Message>.from(controller.messages), // ✅ cast for Chat widget
            user: types.User(id: widget.currentUserId),
            onSendPressed: (partialText) => controller.sendMessage(partialText.text),
            theme: const CustomChatTheme(primaryColor: Color(0xFFF8F9FB)), // ✅ was wrong color
            customMessageBuilder: (message, {required messageWidth}) {
              final meta = message.metadata ?? {};
              final postId = meta['post_id'];
              final text = meta['text'] ?? '';

              if (postId != null) return _postMessage(meta, message.author.id);
              return _textMessage(text, message.author.id);
            },
          );
      }),
    );
  }


  Widget _postMessage(Map meta, String senderId) {
    final isMe = senderId == widget.currentUserId;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.72,
        margin: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: isMe ? 48 : 10,
          right: isMe ? 10 : 48,
        ),
        decoration: BoxDecoration(
          gradient: _primaryGradient,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 6),
            bottomRight: Radius.circular(isMe ? 6 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: _primary.withOpacity(0.32),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post author row
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 13,
                    backgroundColor: Colors.white24,
                    backgroundImage: meta['post_user_profile'] != null
                        ? NetworkImage(meta['post_user_profile'])
                        : null,
                    child: meta['post_user_profile'] == null
                        ? Text(
                      (meta['post_user_name'] ?? 'U')[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                        : null,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      meta['post_user_name'] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  InkWell(onTap: (){
                    Get.to(
                          () => PostViewDetailScreen(id: meta['post_id']),
                      transition: Transition.rightToLeft,
                    );

                  },
                    child: const Icon(
                      Icons.open_in_new_rounded,
                      color: Colors.white38,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ),


            Image.network(
              meta['text'] ?? '',
              height: 185,
              width: double.infinity,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return Container(
                  height: 185,
                  color: Colors.white10,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: progress.expectedTotalBytes != null
                          ? progress.cumulativeBytesLoaded /
                          progress.expectedTotalBytes!
                          : null,
                      color: Colors.white54,
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (_, __, ___) => Container(
                height: 185,
                color: Colors.white10,
                child: const Icon(
                  Icons.broken_image_outlined,
                  color: Colors.white38,
                  size: 40,
                ),
              ),
            ),

            // Caption + timestamp
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      meta['post_caption'] ?? 'Check this out!',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatTime(meta['timestamp']),
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 10.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _textMessage(String text, String senderId) {
    final isMe = senderId == widget.currentUserId;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.70,
        ),
        margin: EdgeInsets.only(
          top: 2,
          bottom: 2,
          left: isMe ? 48 : 10,
          right: isMe ? 10 : 48,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
        decoration: BoxDecoration(
          gradient: isMe ? _primaryGradient : null,
          color: isMe ? null : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 6),
            bottomRight: Radius.circular(isMe ? 6 : 20),
          ),
          boxShadow: [
            BoxShadow(
              color: isMe
                  ? _primary.withOpacity(0.28)
                  : Colors.black.withOpacity(0.07),
              blurRadius: isMe ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isMe ? Colors.white : const Color(0xFF1A1A2E),
            fontSize: 15,
            height: 1.45,
          ),
        ),
      ),
    );
  }


  String _formatTime(dynamic timestamp) {
    if (timestamp == null) return '';
    try {
      final dt = timestamp is DateTime
          ? timestamp
          : DateTime.fromMillisecondsSinceEpoch(
        int.tryParse(timestamp.toString()) ?? 0,
      );
      final h = dt.hour.toString().padLeft(2, '0');
      final m = dt.minute.toString().padLeft(2, '0');
      return '$h:$m';
    } catch (_) {
      return '';
    }
  }
}