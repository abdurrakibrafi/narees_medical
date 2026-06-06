import 'dart:developer';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../uitilies/api/local_storage.dart';

class SocketController extends GetxController {
  String? receiverId;
  late IO.Socket socket;

  var messages = <dynamic>[].obs;
  var messagesOfNursePatient = <dynamic>[].obs;
  var isConnected = false.obs;

  final StorageService _storageService = Get.put(StorageService());

  String? accessToken;
  String? id;

  // নিজের general message event
  String get myEventName => "messages::$id";

  // Nurse-Patient conversation event
  String get nursePatientEventName => "messages::$receiverId";

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
        listenMessages(); // general messages
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

  // ─────────────────────────────────────────────
  // General messages (নিজের event)
  // ─────────────────────────────────────────────
  void listenMessages() {
    socket.off(myEventName);
    socket.on(myEventName, (data) {
      log("📩 listenMessages: $data");
      try {
        if (data is Map && data.containsKey("data")) {
          final newMessages = data["data"];
          if (newMessages is List) {
            // ✅ normal order — পুরনো আগে, নতুন পরে
            messages.assignAll(List.from(newMessages));
          } else {
            messages.add(newMessages);
          }
        } else {
          messages.add(data);
        }
        socket.emit("ack", {"event": myEventName});
      } catch (e) {
        log("❌ Parse Error: $e");
      }
    });
  }

  // ─────────────────────────────────────────────
  // Nurse-Patient conversation listen

  // ─────────────────────────────────────────────
  void listenMessagesOfNursePatient(String receiverId) {
    final event = nursePatientEventName;
    socket.off(event);
    socket.on(event, (data) {
      log("📩 listenMessagesOfNursePatient [$event]: $data");
      try {
        if (data is Map && data.containsKey("data")) {
          final newMessages = data["data"];
          if (newMessages is List) {
            // ✅ reversed সরানো হয়েছে — normal order রাখো
            final incoming = List.from(newMessages);

            if (messagesOfNursePatient.isEmpty) {
              // প্রথমবার — সব replace করো
              messagesOfNursePatient.assignAll(incoming);
            } else {
              // নতুন message আলাদা করে add করো, পুরোটা replace না করে
              for (final msg in incoming) {
                final createdAt = msg['createdAt']?.toString();
                final alreadyExists = messagesOfNursePatient.any(
                  (m) =>
                      m['createdAt']?.toString() == createdAt &&
                      m['senderId']?.toString() ==
                          msg['senderId']?.toString() &&
                      m['content']?.toString() == msg['content']?.toString(),
                );
                if (!alreadyExists) {
                  messagesOfNursePatient.add(msg);
                }
              }
            }

            // ✅ createdAt অনুযায়ী sort — পুরনো আগে
            messagesOfNursePatient.sort((a, b) {
              final aTime =
                  DateTime.tryParse(a['createdAt'] ?? '') ?? DateTime(0);
              final bTime =
                  DateTime.tryParse(b['createdAt'] ?? '') ?? DateTime(0);
              return aTime.compareTo(bTime);
            });
          } else {
            // Single new message — শেষে add করো
            _addSingleMessage(newMessages);
          }
        } else if (data is Map) {
          // Single message directly
          _addSingleMessage(data);
        }
        socket.emit("ack", {"event": event});
      } catch (e) {
        log("❌ Parse Error: $e");
      }
    });
  }

  // ─────────────────────────────────────────────
  // Single message add helper (duplicate check সহ)
  // ─────────────────────────────────────────────
  void _addSingleMessage(dynamic msg) {
    final createdAt = msg['createdAt']?.toString();
    final alreadyExists = messagesOfNursePatient.any(
      (m) =>
          m['createdAt']?.toString() == createdAt &&
          m['senderId']?.toString() == msg['senderId']?.toString() &&
          m['content']?.toString() == msg['content']?.toString(),
    );
    if (!alreadyExists) {
      messagesOfNursePatient.add(msg);
    }
  }

  // ─────────────────────────────────────────────
  // fetchMessagesWithReceiver
  // ─────────────────────────────────────────────
  void fetchMessagesWithReceiver(String receiverId) {
    listenMessagesOfNursePatient(receiverId);
  }

  // ─────────────────────────────────────────────
  // Clear
  // ─────────────────────────────────────────────
  void clearMessages() {
    messagesOfNursePatient.clear();
  }

  // ─────────────────────────────────────────────
  // General send (নিজের chat)
  // ─────────────────────────────────────────────
  void sendMessage(String text) {
    if (!isConnected.value) return;

    // ✅ Optimistic update — শেষে add করো
    messages.add({
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

  // ─────────────────────────────────────────────
  // Nurse → Patient message send
  // ─────────────────────────────────────────────
  void sendMessageFromNurseToPatient(
    String text,
    dynamic receiverId, {
    List<String> files = const [],
  }) {
    if (!isConnected.value) return;

    // ✅ Optimistic update — insert(0) না, শেষে add করো
    messagesOfNursePatient.add({
      "content": text,
      "files": files,
      "receiverId": receiverId.toString(),
      "senderId": id,
      "createdAt": DateTime.now().toIso8601String(),
    });

    socket.emitWithAck(
      "send-message",
      {
        "content": text,
        "files": files,
        "receiverId": receiverId,
      },
      ack: (response) {
        log("✅ ACK: $response");
      },
    );
  }

  // ─────────────────────────────────────────────
  // Disconnect
  // ─────────────────────────────────────────────
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
