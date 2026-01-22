import 'package:aadaiz_customer_crm/src/views/customer_crm/app_components/app_colors.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/controller/ChatMessageController.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/controller/ChatSocketController.dart';
import 'package:aadaiz_customer_crm/src/views/customer_crm/chat/screens/voice_call.dart';
import 'package:aadaiz_customer_crm/src/views/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:chatview/chatview.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:developer';

import 'package:dio/dio.dart';

class ChatScreen extends StatefulWidget {
  final String token;
  final String orderId;
  final String? customerId;
  final String userId;
  final String senderType;
  final String? name;
  final String adminName;
  final String adminProfile;
  final String shopName;
  const ChatScreen({
    super.key,
    required this.token,
    required this.orderId,
    required this.customerId,
    required this.userId,
    required this.senderType,
    this.name,
    required this.adminName,
    required this.adminProfile,
    required this.shopName
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatSocketController socketCon;
  late final ChatMessageController msgCon;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    log('token ${widget.token}');
    log('orderId ${widget.orderId}');
    log('userId ${widget.userId}');
    log('senderType ${widget.senderType}');
    log('customerId ${widget.customerId}');

    socketCon = Get.find<ChatSocketController>();
    msgCon = Get.find<ChatMessageController>();

    /// ALWAYS create a fresh ChatController
    msgCon.initializeController(
      currentUserId: widget.userId.toString(), // my login id
      customerId: widget.customerId.toString(), // opponent id
      // currentUserType: 'admin',
      currentUserType: 'customer',
    );

    loadConversation().then((_) {
      socketCon.connect(
        token: widget.token,
        orderId: widget.orderId,
        userId: widget.userId,
        senderType: widget.senderType,
      );
    });

    socketCon.onMessage = (data) {
      msgCon.addMessage(data);
    };
  }

  Future<void> loadConversation() async {
    setState(() => isLoading = true);

    try {
      final res = await Dio().get(
        "https://aadaizcrm.aadaiz.com/aadaizcrm-new/public/index.php/api/messages/${widget.orderId}",
        queryParameters: {"token": widget.token},
      );

      if (res.statusCode == 200 && res.data['status'] == true) {
        final list = res.data['data']['data'] ?? [];

        msgCon.clearMessages();

        for (var m in list) {
          msgCon.addMessage(Map<String, dynamic>.from(m));
        }
      }
    } catch (e) {
      log("❌ loadConversation error → $e");
    }

    if (mounted) setState(() => isLoading = false);
  }

  @override
  void dispose() {
    socketCon.onClose();
    msgCon.disposeController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          isLoading
              ? const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    color: AppColors.projectcolor,
                    strokeWidth: 2,
                  ),
                ),
              )
              : ChatView(
                featureActiveConfig: const FeatureActiveConfig(
                  enableReactionPopup: false,
                  enableDoubleTapToLike: false,
                  enableSwipeToReply: false,
                  enableReplySnackBar: false,
                ),
                chatBackgroundConfig:  ChatBackgroundConfiguration(
                  backgroundColor: AppColors.greenColor.withAlpha(20)
                  // backgroundImage:
                  //     "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/96e750b6-3aea-4888-983a-d8f0a10ca98d/di04w97-65e15894-7da7-4bd2-be97-0d757006cb9f.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7InBhdGgiOiIvZi85NmU3NTBiNi0zYWVhLTQ4ODgtOTgzYS1kOGYwYTEwY2E5OGQvZGkwNHc5Ny02NWUxNTg5NC03ZGE3LTRiZDItYmU5Ny0wZDc1NzAwNmNiOWYucG5nIn1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmZpbGUuZG93bmxvYWQiXX0.ekeiqsRQjTV90GR4H9Wbh1cwXvAOjFbGPmoufrEG13k",
                ),
                chatBubbleConfig: ChatBubbleConfiguration(
                  outgoingChatBubbleConfig: const ChatBubble(
                    color: Color(0xFFDCFFCF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                    padding: EdgeInsets.all(8),
                  ),

                  inComingChatBubbleConfig: ChatBubble(
                    color: Colors.grey.shade200,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14),
                      bottomRight: Radius.circular(14),
                    ),
                    textStyle: const TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 0),
                    padding: const EdgeInsets.all(10),
                  ),
                ),

                sendMessageConfig: const SendMessageConfiguration(
                  enableCameraImagePicker: false,
                  enableGalleryImagePicker: false,
                  allowRecordingVoice: false,

                  textFieldConfig: TextFieldConfiguration(
                    textStyle: TextStyle(color: Colors.black),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  ),

                  sendButtonIcon: Icon(
                    Icons.send_rounded,
                    size: 26,
                    color: Color(0xFF0057FF),
                  ),
                ),

                chatController: msgCon.chatController,
                chatViewState: ChatViewState.hasMessages,
                appBar: Container(
                  color: AppColors.whiteColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 45,
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () => Get.back(),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue.shade50,
                          child: (widget.adminProfile != null && widget.adminProfile!.isNotEmpty)
                              ? ClipOval(
                            child: Image.network(
                              widget.adminProfile!,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => _adminInitial(),
                            ),
                          )
                              : _adminInitial(),
                        ),

                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.adminName ?? "User",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.call, size: 26),
                          onPressed: () async {
                            final tempChannel = "testchannelname";

                            final callData = await msgCon.callOthers(
                              ProfileController.to.profileData.value.username ??
                                  'Unknown',
                              widget.userId,

                              widget.orderId,
                            );
                            log('Sended channel Name to api: $tempChannel');

                            if (callData != null) {
                              // Corrected log syntax using ${} for the variable
                              log(
                                'Channel which is same as what I sent to API: ${callData['channelName']}',
                              );
                              await Get.to(
                                () => VoiceCallScreen(
                                  channelName:
                                      callData['channelName'], // use server channel
                                  appId: "2db6113c15e748c696c5ac428edf2c0d",
                                  token:
                                      callData['agoraToken'], // use server token
                                  callId: callData['id'],
                                  callerName: widget.shopName,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                onSendTap: (text, reply, type) {
                  String? pickedPath;

                  if (type == MessageType.image) {
                    pickedPath = text;
                    text = "";
                  }

                  socketCon.sendMessage(
                    token: widget.token,
                    orderId: widget.orderId,
                    userId: widget.userId,
                    senderType: widget.senderType,
                    message: text,
                    pickedFilePath: pickedPath,
                  );
                },
              ),
    );
  }
  Widget _adminInitial() {
    return Text(
      (widget.adminName?.isNotEmpty ?? false)
          ? widget.adminName!.substring(0, 1).toUpperCase()
          : "",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.blue,
      ),
    );
  }

}
