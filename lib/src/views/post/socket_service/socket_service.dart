import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket socket;

  SocketService();

  void connect() {
    socket = IO.io(
      "http://13.202.37.237:7000",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();

    socket.onConnect((_) => log("✅ Connected: ${socket.id}"));
    socket.onDisconnect((_) => log("❌ Disconnected"));
  }

  void joinRoom({required String conversationId, required String token}) {
    socket.emit("join_room", {
      "conversation_id": conversationId,
      "token": token,
    });
  }

  void

  sendMessage({
    required String conversationId,
    required String receiverId,
    required String senderId,
    String? message,
    String? file,
    required String token,
    String? tempId,
  }) {
    socket.emit("send_message", {
      "conversation_id": conversationId,
      "receiver_id": receiverId,
      "sender_id": senderId,
      "message": message,
      "file": file,
      "token": token,
      "temp_id": tempId,
    });
  }

  void sendTyping({required String conversationId}) {
    socket.emit("typing", {"conversation_id": conversationId});
  }

  void dispose() {
    socket.dispose();
  }
}
