import 'dart:developer';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../uitilies/api/local_storage.dart';

class SocketController extends GetxController {
  late IO.Socket socket;

  // 🔥 Observable messages
  var messages = <dynamic>[].obs;

  // 🔥 connection status
  var isConnected = false.obs;

  /// storage
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

  // ✅ CONNECT SOCKET
  void connectSocket() {
    try {
      socket = IO.io(
        "http://10.10.10.3:4001",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({
              "token": accessToken ?? "",
            })
            .build(),
      );

      socket.connect();

      // ✅ CONNECTED
      socket.onConnect((_) {
        log("✅ Socket Connected");
        isConnected.value = true;


        // ✅ এটা দিয়ে server কে trigger করুন যাতে সে history পাঠায়
        socket.emit("send-message", {
          "content": "",  // empty content
        });
        listenMessages();
      });




      // ❌ DISCONNECTED
      socket.onDisconnect((_) {
        log("❌ Disconnected");
        isConnected.value = false;
      });

      // ❌ ERROR
      socket.onError((err) {
        log("❌ Error: $err");
      });
    } catch (e) {
      log("❌ Exception: $e");
    }
  }

  // ✅ LISTEN MESSAGE WITH ACK
  void listenMessages() {
    socket.on(eventName, (data) {
      log("📩 Raw Data: $data");

      try {
        if (data is Map && data.containsKey("data")) {
          final newMessages = data["data"];

          if (newMessages is List) {
            messages.assignAll(newMessages.reversed.toList()); // reverse for ListView.reverse=true
          } else {
            messages.add(newMessages);
          }
        } else {
          messages.add(data);
        }

        socket.emit("ack", {
          "event": eventName,
        });
      } catch (e) {
        log("❌ Parse Error: $e");
      }
    });
  }

  // ✅ SEND MESSAGE WITH ACK CALLBACK
  void sendMessage(String text) {
    if (!isConnected.value) return;

    socket.emitWithAck("send-message", {
      "content": text,
    }, ack: (response) {
      log("✅ Server ACK: $response");

      // ✅ ACK পাওয়ার পর তাৎক্ষণিক UI update
      messages.insert(0, {
        "content": text,
        "senderId": id,
        "createdAt": DateTime.now().toIso8601String(),
      });

      // ✅ Server থেকে latest messages আনো
      listenMessages();
    });
  }

  // ✅ DISCONNECT
  void disconnectSocket() {
    socket.disconnect(); // ✅ আগে disconnect
    socket.dispose();    // তারপর dispose
  }

  @override
  void onClose() {
    disconnectSocket();
    super.onClose();
  }
}
