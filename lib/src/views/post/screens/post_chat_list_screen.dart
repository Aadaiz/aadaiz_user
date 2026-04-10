import 'package:aadaiz_customer_crm/src/res/widgets/common_app_bar.dart';
import 'package:aadaiz_customer_crm/src/utils/colors.dart';
import 'package:aadaiz_customer_crm/src/utils/responsive.dart';
import 'package:aadaiz_customer_crm/src/views/post/controller/post_controller.dart';
import 'package:aadaiz_customer_crm/src/views/post/model/post_chat_list_model.dart'
    as postchatlist;
import 'package:aadaiz_customer_crm/src/views/post/screens/chat_screen.dart';
import 'package:aadaiz_customer_crm/src/views/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostChatListScreen extends StatefulWidget {
  const PostChatListScreen({super.key});

  @override
  State<PostChatListScreen> createState() => _PostChatListScreenState();
}

class _PostChatListScreenState extends State<PostChatListScreen> {
  final PostController controller = Get.find();
  final TextEditingController _searchController = TextEditingController();
  final RxList<postchatlist.Datum> _filteredList = <postchatlist.Datum>[].obs;

  @override
  void initState() {
    super.initState();
    controller.getChatList();
    _filteredList.assignAll(controller.chatList);

    ever(controller.chatList, (_) {
      _filterChats(_searchController.text);
    });
  }

  void _filterChats(String query) {
    if (query.trim().isEmpty) {
      _filteredList.assignAll(controller.chatList);
    } else {
      _filteredList.assignAll(
        controller.chatList.where((chat) {
          final name = chat.user?.username?.toLowerCase() ?? '';
          return name.contains(query.toLowerCase().trim());
        }).toList(),
      );
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    final now = DateTime.now();
    final diff = now.difference(dateTime);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m';
    if (diff.inHours < 24) return '${diff.inHours}h';
    if (diff.inDays < 7) return '${diff.inDays}d';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, 6.0.hp),
        child: CommonAppBar(leadingclick: () => Get.back(), title: 'Messages'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFF3F4F6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => _filterChats(value),
                decoration: InputDecoration(
                  hintText: 'Search messages...',
                  hintStyle: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 14,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade500,
                    size: 20,
                  ),
                  suffixIcon:
                      _searchController.text.isNotEmpty
                          ? GestureDetector(
                            onTap: () {
                              _searchController.clear();
                              _filterChats('');
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.grey.shade400,
                              size: 18,
                            ),
                          )
                          : const SizedBox.shrink(),

                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),

          Expanded(
            child: Obx(() {
              if (controller.getChatListLoading.value) {
                return  Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColor.primary,
                  ),
                );
              }

              if (_filteredList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off_rounded,
                        size: 64,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _searchController.text.isNotEmpty
                            ? 'No results for "${_searchController.text}"'
                            : 'No messages yet',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            'Try a different name',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                itemCount: _filteredList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final chat = _filteredList[index];
                  final bool isUnread = index % 3 == 0;

                  return InkWell(
                    onTap: () async {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      final token = prefs.getString("token");
                      await Get.to(
                        () => PostChatScreen(
                          conversationId: chat.conversationId.toString(),
                          receiverId: chat.user!.id.toString(),
                          token: token!,
                          currentUserId:
                              ProfileController.to.profileData.value.id
                                  .toString(),
                          profileName: chat.user!.username.toString(),
                          profileImage: chat.user!.profileImage.toString(),
                        ),
                     transition: Transition.rightToLeft,
                        );
                    },
                    borderRadius: BorderRadius.circular(14),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color:
                            isUnread
                                ? const Color(0xFF6C63FF).withOpacity(0.05)
                                : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: Colors.grey.shade200,
                                backgroundImage:
                                    (chat.user?.profileImage != null &&
                                            chat.user!.profileImage!.isNotEmpty)
                                        ? NetworkImage(chat.user!.profileImage!)
                                        : null,
                                child:
                                    (chat.user?.profileImage == null ||
                                            chat.user!.profileImage!.isEmpty)
                                        ? Text(
                                          (chat.user?.username ?? 'U')[0]
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF6C63FF),
                                          ),
                                        )
                                        : null,
                              ),
                              Positioned(
                                bottom: 1,
                                right: 1,
                                child: Container(
                                  width: 12,
                                  height: 12,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF22C55E),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildHighlightedText(
                                      chat.user?.username ?? 'Unknown',
                                      _searchController.text,
                                    ),
                                    Text(
                                      _formatTime(chat.lastMessageTime),
                                      style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            isUnread
                                                ? const Color(0xFF6C63FF)
                                                : Colors.grey.shade400,
                                        fontWeight:
                                            isUnread
                                                ? FontWeight.w600
                                                : FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        chat.lastMessage ?? 'No messages yet',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              isUnread
                                                  ? const Color(0xFF374151)
                                                  : Colors.grey.shade500,
                                          fontWeight:
                                              isUnread
                                                  ? FontWeight.w500
                                                  : FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    if (isUnread)
                                      Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF6C63FF),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedText(String fullText, String query) {
    if (query.isEmpty) {
      return Text(
        fullText,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xFF111827),
        ),
      );
    }

    final lowerText = fullText.toLowerCase();
    final lowerQuery = query.toLowerCase().trim();
    final matchIndex = lowerText.indexOf(lowerQuery);

    if (matchIndex == -1) {
      return Text(
        fullText,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Color(0xFF111827),
        ),
      );
    }

    return RichText(
      text: TextSpan(
        children: [
          if (matchIndex > 0)
            TextSpan(
              text: fullText.substring(0, matchIndex),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
          TextSpan(
            text: fullText.substring(
              matchIndex,
              matchIndex + lowerQuery.length,
            ),
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xFF6C63FF), // highlighted match
              backgroundColor: Color(0xFFEDE9FE),
            ),
          ),
          if (matchIndex + lowerQuery.length < fullText.length)
            TextSpan(
              text: fullText.substring(matchIndex + lowerQuery.length),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
        ],
      ),
    );
  }
}
