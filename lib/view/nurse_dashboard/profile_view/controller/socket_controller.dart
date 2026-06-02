import 'dart:developer';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../uitilies/api/local_storage.dart';

class SocketController extends GetxController {
  late IO.Socket socket;

  var messages = <dynamic>[].obs;
  var messagesOfNursePatient = <dynamic>[].obs;
  var isConnected = false.obs;

  final StorageService _storageService = Get.put(StorageService());

  String? accessToken;
  String? id;

  String get eventName => "messages::$id";

  @override
  void onInit() {
    super.onInit();
    accessToken = _storageService.read<String>('accessToken');
    id = _storageService.read<String>('id');
    connectSocket();
  }

  void connectSocket() {
    try {
      socket = IO.io(
        "http://10.10.10.3:4001",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({"token": accessToken ?? ""})
            .build(),
      );

      socket.connect();

      socket.onConnect((_) {
        log("✅ Socket Connected");
        isConnected.value = true;
        listenMessages();
      });

      socket.onDisconnect((_) {
        log("❌ Disconnected");
        isConnected.value = false;
      });

      socket.onError((err) => log("❌ Error: $err"));
    } catch (e) {
      log("❌ Exception: $e");
    }
  }

  void listenMessages() {
    socket.off(eventName); // ✅ আগের listener সরাও
    socket.on(eventName, (data) {
      log("📩 listenMessages: $data");
      try {
        if (data is Map && data.containsKey("data")) {
          final newMessages = data["data"];
          if (newMessages is List) {
            messages.assignAll(newMessages.reversed.toList());
          } else {
            messages.add(newMessages);
          }
        } else {
          messages.add(data);
        }
        socket.emit("ack", {"event": eventName});
      } catch (e) {
        log("❌ Parse Error: $e");
      }
    });
  }

  void listenMessagesOfNursePatient() {
    socket.off(eventName); // ✅ KEY FIX — duplicate listener বন্ধ
    socket.on(eventName, (data) {
      log("📩 listenMessagesOfNursePatient: $data");
      try {
        if (data is Map && data.containsKey("data")) {
          final newMessages = data["data"];
          if (newMessages is List) {
            messagesOfNursePatient.assignAll(newMessages.reversed.toList());
          } else {
            messagesOfNursePatient.add(newMessages);
          }
        } else {
          messagesOfNursePatient.add(data);
        }
        socket.emit("ack", {"event": eventName});
      } catch (e) {
        log("❌ Parse Error: $e");
      }
    });
  }

  void clearMessages() {
    messagesOfNursePatient.clear();
  }

  void sendMessage(String text) {
    if (!isConnected.value) return;

    messages.insert(0, {
      "content": text,
      "senderId": id,
      "createdAt": DateTime.now().toIso8601String(),
    });

    socket.emitWithAck("send-message", {
      "content": text,
    }, ack: (response) {
      log("✅ ACK: $response");
    });
  }

  void sendMessageFromNurseToPatient(String text, dynamic receiverId,
      {List<String> files = const []}) {
    if (!isConnected.value) return;

    // ✅ আগেই locally insert — ACK এর অপেক্ষা না করে
    messagesOfNursePatient.insert(0, {
      "content": text,
      "files": files,
      "receiverId": receiverId.toString(),
      "senderId": id,
      "createdAt": DateTime.now().toIso8601String(),
    });

    socket.emitWithAck("send-message", {
      "content": text,
      "files": files,
      "receiverId": receiverId,
    }, ack: (response) {
      log("✅ ACK: $response");
    });
  }

  void disconnectSocket() {
    socket.disconnect();
    socket.dispose();
  }

  @override
  void onClose() {
    disconnectSocket();
    super.onClose();
  }
}