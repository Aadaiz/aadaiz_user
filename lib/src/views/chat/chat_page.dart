// import 'dart:convert';
// import 'dart:io';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_chat_ui/flutter_chat_ui.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// import 'package:google_fonts/google_fonts.dart';
// import 'package:path_provider/path_provider.dart';
// import 'chat_controller.dart';
// import 'package:http/http.dart' as http;
//
//
// class ChatPage extends StatelessWidget {
//   final ChatController controller = Get.put(ChatController());
//
//   ChatPage({super.key});
//
//   // Future<void> pickImage() async {
//   //   final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
//   //   if (picked != null) {
//   //     controller.sendImage(File(picked.path));
//   //   }
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         elevation: 0,
//         titleSpacing: 0,
//         title: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12.w),
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: () =>Get.back(),
//                 child:  Icon(Icons.keyboard_arrow_left,size: 36.w,),
//               ),
//
//               CircleAvatar(
//                 radius: 18.5.r,
//                 backgroundColor: Colors.black,
//                 child: CircleAvatar(
//                   radius: 18.r,
//                   backgroundImage: NetworkImage(
//                     'https://t4.ftcdn.net/jpg/05/07/95/21/360_F_507952111_67OxZSqsFTUPiSkKqb7QkSmdEo5WFght.jpg', // Replace with your logo image
//                   ),
//                 ),
//               ),
//               SizedBox(width: 8.w),
//               Text(
//                 'Chat with team',
//                 style: GoogleFonts.montserrat(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black,
//                 ),
//               ),
//               const Spacer(),
//               Padding(
//                 padding: const EdgeInsets.only(right: 16.0),
//                 child: InkWell(
//                     onTap: (){
//                       Random random = Random();
//                       int randomNumber = random.nextInt(100);
//                       String name = randomNumber.toString();
//                       // Get.to(CallPage(user: name,));
//                     },
//
//                     child: Image.asset("assets/images/call.png",height: 18.h,width: 18,)),
//               )
//
//             ],
//           ),
//         ),
//       ),
//       body: Obx(() => Chat(
//         messages: controller.messages.toList(),
//         onSendPressed: (partialText) {
//           controller.sendMessage(partialText.text);
//         },
//        // onAttachmentPressed: pickImage,
//         user: const types.User(id: '2'), // your ID
//         theme: const DefaultChatTheme(
//           primaryColor: Color(0xff003366), // dark blue
//           secondaryColor: Color(0xfff2f2f2), // light grey
//           inputBackgroundColor: Colors.white,
//           inputTextColor: Colors.black,
//           backgroundColor: Colors.white,
//           sentMessageBodyTextStyle: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//           ),
//           receivedMessageBodyTextStyle: TextStyle(
//             color: Colors.black87,
//             fontSize: 16,
//           ),
//           dateDividerTextStyle: TextStyle(
//             color: Colors.grey,
//             fontSize: 12,
//           ),
//         ),
//         customBottomWidget: _customBottomBar(context),
//       )),
//     );
//   }
//
//   Widget _customBottomBar(BuildContext context) {
//     final TextEditingController _controller = TextEditingController();
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                 borderRadius: BorderRadius.circular(30), // Rounded corners
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _controller,
//                       decoration: const InputDecoration(
//                         hintText: "Type a message",
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   Image.asset(
//                     'assets/images/gal.png',
//                     height: 24,
//                     width: 24,
//                     fit: BoxFit.cover,
//                   ),
//                   const SizedBox(width: 12),
//                   Image.asset(
//                     'assets/images/com.png',
//                     height: 24,
//                     width: 24,
//                     fit: BoxFit.cover,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           Container(
//             padding: const EdgeInsets.all(12),
//             decoration: const BoxDecoration(
//               color: Color(0xFF0C1B46), // Dark blue color
//               shape: BoxShape.circle,
//             ),
//             child: Icon(
//               Icons.mic,
//               color: Colors.white,
//               size: 24,
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//
// }
//
//
