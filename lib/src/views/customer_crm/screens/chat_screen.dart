import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:aadaiz_customer_crm/src/views/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import '../../../utils/image_compress.dart';
import '../../chat/chat_controller.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, this.shopName, this.shopId, this.orderId});
  final dynamic shopName;
  final dynamic shopId;
  final dynamic orderId;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatController controller = Get.put(ChatController());
  final TextEditingController _controller = TextEditingController();
  String currentText = '';
  @override
  void initState() {
    super.initState();
    controller.connectSocket(widget.shopId, widget.orderId);
    controller.getOtherUser(widget.shopId);
  }

  void pickImage(isCamera) async {
    final ImagePicker _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
    );
    final compressedFile = await Images().compressImage(imageFile: pickedFile!);
    if (compressedFile != null) {
      controller.sendImage(compressedFile);
    }

    setState(() {
      //compressedFile.path = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Icon(Icons.keyboard_arrow_left, size: 36.w),
              ),
              CircleAvatar(
                radius: 18.5.r,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 18.r,
                  backgroundImage: const NetworkImage(
                    'https://t4.ftcdn.net/jpg/05/07/95/21/360_F_507952111_67OxZSqsFTUPiSkKqb7QkSmdEo5WFght.jpg', // Replace with your logo image
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                '${widget.shopName ?? ''}',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              ZegoSendCallInvitationButton(
                isVideoCall: false,
                buttonSize: const Size(100, 100),
                iconSize: const Size(40, 40),
                icon: ButtonIcon(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/call.png", // Path to your image
                      width: 20,
                      height: 20,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                resourceID: "aadaiz_call",
                invitees: [ZegoUIKitUser(id: "456", name: "shop")],
              ),
            ],
          ),
        ),
      ),
      body: Obx(
        () => Chat(
          messages: controller.messages.toList(),
          onSendPressed: (partialText) {
            controller.sendMessage(
              partialText.text,
              ProfileController.to.profileData.value.id,
              widget.shopId,
              widget.orderId,
            );
          },
          // onAttachmentPressed: pickImage,
          user: types.User(
            id: '${ProfileController.to.profileData.value.id}',
          ), // your ID
          theme: const DefaultChatTheme(
            primaryColor: Color(0xff003366), // dark blue
            secondaryColor: Color(0xfff2f2f2), // light grey
            inputBackgroundColor: Colors.white,
            inputTextColor: Colors.black,
            backgroundColor: Colors.white,
            sentMessageBodyTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
            receivedMessageBodyTextStyle: TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
            dateDividerTextStyle: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          customBottomWidget: _customBottomBar(context),
        ),
      ),
    );
  }

  Widget _customBottomBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30), // Rounded corners
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Type a message",
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          currentText = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => pickImage(false),
                    child: Image.asset(
                      'assets/images/gal.png',
                      height: 24,
                      width: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => pickImage(true),
                    child: Image.asset(
                      'assets/images/com.png',
                      height: 24,
                      width: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              if (currentText.trim().isNotEmpty) {
                final text = _controller.text.trim();
                if (text.isNotEmpty) {
                  controller.sendMessage(
                    text,
                    ProfileController.to.profileData.value.id,
                    widget.shopId,
                    widget.orderId,
                  );
                  _controller.clear();
                }
              }
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFF0C1B46), // Dark blue color
                shape: BoxShape.circle,
              ),
              child: Icon(
                //currentText.trim().isNotEmpty ?
                Icons.send,
                //  : Icons.mic,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
