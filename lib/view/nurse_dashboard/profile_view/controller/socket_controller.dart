import 'dart:developer';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../uitilies/api/local_storage.dart';

class SocketController extends GetxController {
  late IO.Socket socket;

  final messages = <dynamic>[].obs;
  final messagesOfNursePatient = <dynamic>[].obs;
  final isConnected = false.obs;

  final StorageService _storageService = Get.put(StorageService());

  String? accessToken;
  String? id;

  String? currentReceiverId;
  String? currentNursePatientEvent;

  String get myEventName => "messages::$id";

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
        //"http://10.10.10.3:4001",
        "https://9a14-103-159-73-203.ngrok-free.app",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({
              "token": accessToken ?? "",
            })
            .build(),
      );

      socket.connect();

      socket.onConnect((_) {
        log("✅ Socket Connected");
        isConnected.value = true;
        // dunamichly
        listenMessages();
        //    listenMessagesOfNursePatient("69dc6ee5d2b547fd2cbe0052");
      });

      socket.onDisconnect((_) {
        log("❌ Socket Disconnected");
        isConnected.value = false;
      });

      socket.onError((err) {
        log("❌ Socket Error: $err");
      });
    } catch (e) {
      log("❌ Socket Exception: $e");
    }
  }

  void listenMessagesOfNursePatient(String receiverId) {
    final event = "messages::$receiverId";

    log("🎯 Listening Event: $event");

    messagesOfNursePatient.clear();

    if (currentNursePatientEvent != null) {
      socket.off(currentNursePatientEvent!);
    }

    currentNursePatientEvent = event;

    socket.on(event, (data) {
      log("📩 NursePatient [$event] => $data");

      try {
        if (data is Map && data.containsKey("data")) {
          final incoming = data["data"];

          if (incoming is List) {
            messagesOfNursePatient.assignAll(List.from(incoming));
          } else {
            _addSingleMessage(incoming);
          }
        }
      } catch (e) {
        log("❌ Error: $e");
      }
    });
  }

  void listenMessages() {
    socket.off(myEventName);

    socket.on(myEventName, (data) {
      log("📩 General Message: $data");

      try {
        if (data is Map && data.containsKey("data")) {
          final incoming = data["data"];

          if (incoming is List) {
            messages.assignAll(List.from(incoming));
          } else {
            messages.add(incoming);
          }
        }
      } catch (e) {
        log("❌ General Error: $e");
      }
    });
  }

  void _addSingleMessage(dynamic msg) {
    final exists = messagesOfNursePatient.any((m) {
      return m['createdAt']?.toString() == msg['createdAt']?.toString() &&
          m['senderId']?.toString() == msg['senderId']?.toString() &&
          m['content']?.toString() == msg['content']?.toString();
    });

    if (!exists) {
      messagesOfNursePatient.add(msg);
    }
  }

  void _sortMessages() {
    messagesOfNursePatient.sort((a, b) {
      final aTime =
          DateTime.tryParse(a['createdAt']?.toString() ?? '') ?? DateTime(0);

      final bTime =
          DateTime.tryParse(b['createdAt']?.toString() ?? '') ?? DateTime(0);

      return aTime.compareTo(bTime);
    });
  }

  void fetchMessagesWithReceiver(String receiverId) {
    listenMessagesOfNursePatient(receiverId);
  }

  void clearMessages() {
    messagesOfNursePatient.clear();
  }

  // =====================================================
  // SEND GENERAL MESSAGE
  // =====================================================

  void sendMessage(String text) {
    if (!isConnected.value) return;

    messages.add({
      "content": text,
      "senderId": id,
      "createdAt": DateTime.now().toIso8601String(),
    });

    socket.emitWithAck(
      "send-message",
      {
        "content": text,
      },
      ack: (response) {
        log("✅ ACK: $response");
      },
    );
  }

  // =====================================================
  // SEND NURSE → PATIENT MESSAGE
  // =====================================================

  void sendMessageFromNurseToPatient(
    String text,
    dynamic receiverId, {
    List<String> files = const [],
  }) {
    if (!isConnected.value) return;

    final newMessage = {
      "content": text,
      "files": files,
      "receiverId": receiverId.toString(),
      "senderId": id,
      "createdAt": DateTime.now().toIso8601String(),
    };

    _addSingleMessage(newMessage);

    socket.emitWithAck(
      "send-message",
      {
        "content": text,
        "files": files,
        "receiverId": receiverId,
      },
      ack: (response) {
        log("✅ Send ACK: $response");
      },
    );
  }

  // =====================================================
  // DISCONNECT
  // =====================================================

  void disconnectSocket() {
    socket.disconnect();
    socket.dispose();
  }

  @override
  void onClose() {
    if (currentNursePatientEvent != null) {
      socket.off(currentNursePatientEvent!);
    }

    socket.off(myEventName);

    disconnectSocket();

    super.onClose();
  }
}
