import 'dart:io';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:uuid/uuid.dart';

import '../profile/controller/profile_controller.dart';

class ChatController extends GetxController {
  late IO.Socket socket;
  var messages = <types.Message>[].obs; // ✅ Now strongly typed

  final _user = types.User(id: '${ProfileController.to.profileData.value.id}');
  late var _otherUser = const types.User(id: ''); // Receiver

  // @override
  // void onInit() {
  //   super.onInit();
  //   connectSocket();
  // }
  getOtherUser(receiverId) {
    _otherUser =  types.User(id: '$receiverId');
  }

  void connectSocket(receiverId,orderId) {
    socket = IO.io('http://52.2.234.121:3001/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      print('Socket connected');

      final registerData = {
        'user_id': ProfileController.to.profileData.value.id, // Example user ID
        'username': ProfileController.to.profileData.value.username, // Example username
      };
      socket.emit('register', ProfileController.to.profileData.value.id);
      print("Emitted register: $registerData");

      // Load previous messages
      final msg = {
        'sender_id': ProfileController.to.profileData.value.id,
        'receiver_id': receiverId,
        'order_id': orderId,
      };
      socket.emit('load_messages', msg);
      print("load_messages $msg");
    });

    socket.on('register_response', (data) {
      print("Registration response: $data");
    });

    socket.on('receive_message', (data) {
      print("Received message: $data");

      messages.insert(0, _parseMessage(data));
    });

    socket.on('messages_loaded', (data) {
      print("messages_loaded: $data");

      if (data is List) {
        final loadedMessages = data.map((msg) => _parseMessage(msg)).toList();
        messages.assignAll(loadedMessages.reversed.toList()); // oldest first
      } else if (data is Map) {
        final loadedMessages =
            data.values.map((msg) => _parseMessage(msg)).toList();
        messages.assignAll(loadedMessages.reversed.toList());
      } else {
        print("Unknown format: $data");
      }
    });

    socket.onDisconnect((_) => print('Socket disconnected'));
  }

  void sendMessage(String text, senderId, receiverId, orderId) {
    final msg = {
      'message': text,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'order_id': orderId,
      'type': 'text',
      'sender': 'user',
    };
    socket.emit('send_message', msg);
    print("Emitted: $msg");

    final localMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: text,
    );

    messages.insert(0, localMessage);
  }

  void sendImage(File file) {
    final imageMessage = types.ImageMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      name: file.path.split('/').last,
      size: file.lengthSync(),
      uri: file.path,
    );

    messages.insert(0, imageMessage);
  }

  types.TextMessage _parseMessage(dynamic data) {
    return types.TextMessage(
      author:
          (data['sender_id'] == ProfileController.to.profileData.value.id)
              ? _user
              : _otherUser,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: data['message'] ?? '',
    );
  }

  @override
  void onClose() {
    socket.disconnect();
    super.onClose();
  }
}
