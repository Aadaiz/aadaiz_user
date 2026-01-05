import 'dart:developer';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocketController extends GetxController {
  IO.Socket? socket;
  RxBool isTyping = false.obs;
  Function(Map<String, dynamic>)? onMessage;

  // ---------------- CONNECT ----------------
  void connect({
    required String token,
    required String orderId,
    required String userId,
    required String senderType,
  }) {
    log("🔹 Initializing socket connection...");

    socket = IO.io(
      "http://13.202.37.237:6002",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableForceNew()
          .enableAutoConnect()
          .setQuery({"token": token})
          .build(),
    );

    // On connect
    socket!.onConnect((_) {
      log("🟢 SOCKET CONNECTED");

      socket!.emit("join_room", {"order_id": int.parse(orderId)});
      log("➡️ join_room emitted with order_id = $orderId");
    });

    // On room joined
    socket!.on("joined", (data) => log("📌 Joined Room → $data"));

    // On receive message
    socket!.on("receive_message", (data) {
      log("📩 Message Received → $data");
      onMessage?.call(Map<String, dynamic>.from(data));
    });

    // On typing
    socket!.on("typing", (data) {
      isTyping.value = data["isTyping"] ?? false;
    });

    // Connection errors
    socket!.onDisconnect((_) => log("🔴 SOCKET DISCONNECTED"));
    socket!.onConnectError((err) => log("⚠️ SOCKET CONNECT ERROR → $err"));
    socket!.onError((err) => log("⚠️ SOCKET ERROR → $err"));
  }

  // ------------ SEND MESSAGE --------------
  void sendMessage({
    required String token,
    required String orderId,
    required String userId,
    required String senderType,
    required String message,
    String? pickedFilePath, // local file path from picker
  }) async {
    String? filePath;

    // // If an image/file is picked, upload it first
    // if (pickedFilePath != null) {
    //   filePath = await uploadFile(localFilePath: pickedFilePath, token: token, orderId: orderId, userId: userId, senderType: senderType); // returns "/uploads/filename"
    //   if (filePath == null) {
    //     log("❌ File upload failed, message not sent");
    //     return;
    //   }
    // }

    log("➡️ Sending message → '$message' with file → $filePath");

    socket?.emit("send_message", {
      "order_id": int.parse(orderId),
      "message": message,
      "sender_type": senderType,
      "sender_id": int.parse(userId),
      "file": filePath, // Node backend expects this key "file"
      "token": token,
    });
  }


  // ------------- FILE UPLOAD ----------------
  // uploadFile({
  //   required String localFilePath,
  //   required String token,
  //   required String orderId,
  //   required String userId,
  //   required String senderType,
  //   String message = "",
  // }) async {
  //   final dio = Dio();
  //   final fileName = localFilePath.split('/').last;
  //
  //   final form = FormData.fromMap({
  //     "order_id": int.parse(orderId),
  //     "sender_type": senderType,
  //     "sender_id": int.parse(userId),
  //     "message": message,
  //     "file": await MultipartFile.fromFile(localFilePath, filename: fileName),
  //   });
  //
  //   try {
  //     final res = await dio.post(
  //       "http://52.2.234.121/aadaiz-crm-new/public/index.php/api/messages/store",
  //       data: form,
  //       options: Options(
  //         headers: {"Content-Type": "multipart/form-data"},
  //         validateStatus: (status) => true, // handle manually
  //       ),
  //     );
  //
  //     log("⬆️ Upload response → ${res.statusCode} | ${res.data}");
  //
  //     if (res.statusCode == 201 && res.data["status"] == true) {
  //       log("✅ File message sent successfully");
  //     } else {
  //       log("❌ File message failed → ${res.statusCode} | ${res.data}");
  //     }
  //   } catch (e) {
  //     log("❌ Exception while sending file message → $e");
  //   }
  // }
  //




  // ------------- TYPING --------------------
  void setTyping({
    required String orderId,
    required String senderType,
    required bool value,
  }) {
    socket?.emit("typing", {
      "order_id": int.parse(orderId),
      "sender_type": senderType,
      "isTyping": value,
    });
  }

  @override
  void onClose() {
    log("🔴 Disconnecting socket...");
    socket?.disconnect();
    super.onClose();
  }
}