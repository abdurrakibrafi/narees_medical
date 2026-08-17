import 'dart:developer';

import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../../uitilies/api/local_storage.dart';

class SocketController extends GetxController {
  IO.Socket? socket;

  final messages = <dynamic>[].obs;
  final messagesOfNursePatient = <dynamic>[].obs;

  final isConnected = false.obs;
  final isLoading = false.obs;

  final StorageService _storageService = Get.put(StorageService());

  String? accessToken;
  String? id;

  String? currentReceiverId;
  String? currentNursePatientEvent;

  String get myEventName => "messages::$id";

  @override
  void onInit() {
    super.onInit();

    _loadStoredCredentials();

    // যদি user আগে থেকেই logged in থাকে,
    // তাহলে app restart/open এর সময় socket connect হবে।
    if (_hasValidCredentials()) {
      connectSocket();
    } else {
      log("⛔ Socket not connected: User not logged in yet");
      isLoading.value = false;
    }
  }

  // =====================================================
  // LOAD TOKEN + ID
  // =====================================================

  void _loadStoredCredentials() {
    accessToken = _storageService.read<String>('accessToken');
    id = _storageService.read<String>('id');

    log("🔐 Socket credentials loaded");
    log(
      "🔑 Token available: ${accessToken != null && accessToken!.isNotEmpty}",
    );
    log("👤 User ID: $id");
  }

  bool _hasValidCredentials() {
    return accessToken != null &&
        accessToken!.trim().isNotEmpty &&
        id != null &&
        id!.trim().isNotEmpty;
  }

  // =====================================================
  // CONNECT SOCKET
  // =====================================================

  void connectSocket() {
    try {
      _loadStoredCredentials();

      if (!_hasValidCredentials()) {
        log("⛔ Socket connection cancelled: Token or ID missing");
        isLoading.value = false;
        return;
      }

      // পুরাতন socket থাকলে remove করে দিবে
      _disposeOldSocket();

      isLoading.value = true;
      isConnected.value = false;

      log("🚀 Connecting Socket...");
      log("👤 Connecting User ID: $id");

      socket = IO.io(
        "http://72.60.167.110:4000",
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setExtraHeaders({
          "token": accessToken!,
        })
            .build(),
      );

      socket!.onConnect((_) {
        log("✅ Socket Connected");
        log("🆔 Socket ID: ${socket?.id}");

        isConnected.value = true;
        isLoading.value = false;

        listenMessages();

        // যদি আগে কোনো receiver select করা থাকে
        if (currentReceiverId != null &&
            currentReceiverId!.trim().isNotEmpty) {
          listenMessagesOfNursePatient(currentReceiverId!);
          initialEmit(currentReceiverId!);
        }
      });

      socket!.onConnectError((error) {
        log("❌ Socket Connect Error: $error");

        isConnected.value = false;
        isLoading.value = false;
      });

      socket!.onDisconnect((reason) {
        log("❌ Socket Disconnected");
        log("Reason: $reason");

        isConnected.value = false;
        isLoading.value = false;
      });

      socket!.onError((error) {
        log("❌ Socket Error: $error");

        isLoading.value = false;
      });

      socket!.connect();

      Future.delayed(const Duration(seconds: 5), () {
        if (!isConnected.value && isLoading.value) {
          isLoading.value = false;
          log("⏱ Socket loading timeout — forced off");
        }
      });
    } catch (e, stackTrace) {
      log("❌ Socket Exception: $e");
      log("StackTrace: $stackTrace");

      isConnected.value = false;
      isLoading.value = false;
    }
  }

  // =====================================================
  // RECONNECT AFTER LOGIN
  // =====================================================

  Future<void> reconnectAfterLogin() async {
    log("======================================");
    log("🔄 RECONNECT SOCKET AFTER LOGIN");
    log("======================================");

    _loadStoredCredentials();

    if (!_hasValidCredentials()) {
      log("❌ Cannot reconnect socket");
      log("Token or User ID missing");

      isConnected.value = false;
      isLoading.value = false;
      return;
    }

    _disposeOldSocket();

    messages.clear();
    messagesOfNursePatient.clear();

    isConnected.value = false;
    isLoading.value = true;

    connectSocket();
  }

  // =====================================================
  // GENERAL MESSAGE LISTENER
  // =====================================================

  void listenMessages() {
    if (socket == null) {
      log("❌ listenMessages: Socket is null");
      return;
    }

    if (id == null || id!.trim().isEmpty) {
      log("❌ listenMessages: User ID missing");
      return;
    }

    final eventName = "messages::$id";

    log("🎧 General Message Event: $eventName");

    socket!.off(eventName);

    isLoading.value = true;

    socket!.on(eventName, (data) {
      log("======================================");
      log("📩 GENERAL MESSAGE RECEIVED");
      log("Event: $eventName");
      log("Data: $data");
      log("======================================");

      try {
        if (data is Map && data.containsKey("data")) {
          final incoming = data["data"];

          if (incoming is List) {
            messages.assignAll(List.from(incoming));

            log(
              "✅ General message list received: ${messages.length}",
            );
          } else if (incoming is Map) {
            final content = incoming['content'];

            if (content != null &&
                content.toString().trim().isNotEmpty) {
              messages.add(incoming);

              log("✅ Single general message added");
            }
          }
        }
      } catch (e) {
        log("❌ General Message Error: $e");
      } finally {
        isLoading.value = false;
      }
    });

    Future.delayed(const Duration(seconds: 4), () {
      if (isLoading.value) {
        isLoading.value = false;
        log("⏱ General messages loading timeout");
      }
    });
  }

  // =====================================================
  // NURSE <-> PATIENT MESSAGE LISTENER
  // =====================================================

  void listenMessagesOfNursePatient(String receiverId) {
    if (socket == null) {
      log("❌ NursePatient listen failed: Socket null");
      return;
    }

    currentReceiverId = receiverId;

    final event = "messages::$receiverId";

    log("======================================");
    log("🎯 Listening NursePatient Event");
    log("Event: $event");
    log("======================================");

    messagesOfNursePatient.clear();
    isLoading.value = true;

    if (currentNursePatientEvent != null) {
      socket!.off(currentNursePatientEvent!);
    }

    currentNursePatientEvent = event;

    socket!.on(event, (data) {
      log("======================================");
      log("📩 NURSE PATIENT MESSAGE");
      log("Event: $event");
      log("Data: $data");
      log("======================================");

      try {
        if (data is Map && data.containsKey("data")) {
          final incoming = data["data"];

          if (incoming is List) {
            messagesOfNursePatient.assignAll(
              List.from(incoming),
            );

            log(
              "✅ NursePatient message list: "
                  "${messagesOfNursePatient.length}",
            );
          } else if (incoming is Map) {
            _addSingleMessage(incoming);
          }
        }
      } catch (e) {
        log("❌ NursePatient Error: $e");
      } finally {
        isLoading.value = false;
      }
    });

    Future.delayed(const Duration(seconds: 4), () {
      if (isLoading.value) {
        isLoading.value = false;

        log(
          "⏱ NursePatient loading timeout — forced off",
        );
      }
    });
  }

  // =====================================================
  // ADD SINGLE MESSAGE WITHOUT DUPLICATE
  // =====================================================

  void _addSingleMessage(dynamic msg) {
    if (msg == null || msg is! Map) {
      return;
    }

    final exists = messagesOfNursePatient.any((m) {
      if (m is! Map) return false;

      return m['createdAt']?.toString() ==
          msg['createdAt']?.toString() &&
          m['senderId']?.toString() ==
              msg['senderId']?.toString() &&
          m['content']?.toString() ==
              msg['content']?.toString();
    });

    if (!exists) {
      messagesOfNursePatient.add(msg);

      log("✅ New message added locally");
    } else {
      log("⚠️ Duplicate message ignored");
    }
  }

  // =====================================================
  // INITIAL EMIT
  // =====================================================

  void initialEmit(String receiverId) {
    if (socket == null || !isConnected.value) {
      log("❌ Initial Emit failed: Socket not connected");
      return;
    }

    currentReceiverId = receiverId;

    log("======================================");
    log("📤 INITIAL MESSAGE EMIT");
    log("receiverId: $receiverId");
    log("======================================");

    socket!.emitWithAck(
      "messages",
      {
        "receiverId": receiverId,
      },
      ack: (response) {
        log("✅ Initial Emit ACK: $response");
      },
    );
  }

  // =====================================================
  // CLEAR MESSAGES
  // =====================================================

  void clearMessages() {
    messagesOfNursePatient.clear();
  }

  // =====================================================
  // SEND GENERAL MESSAGE
  // =====================================================

  void sendMessage(String text) {
    if (socket == null || !isConnected.value) {
      log("❌ Send Message failed: Socket not connected");
      return;
    }

    if (text.trim().isNotEmpty) {
      messages.add({
        "content": text,
        "senderId": id,
        "createdAt": DateTime.now().toIso8601String(),
      });
    }

    log("📤 Sending General Message: $text");

    socket!.emitWithAck(
      "send-message",
      {
        "content": text,
      },
      ack: (response) {
        log("✅ General Send ACK: $response");
      },
    );
  }

  // =====================================================
  // SEND NURSE -> PATIENT MESSAGE
  // =====================================================

  void sendMessageFromNurseToPatient(
      String text,
      dynamic receiverId, {
        List<String> files = const [],
      }) {
    if (socket == null || !isConnected.value) {
      log(
        "❌ Nurse → Patient send failed: Socket not connected",
      );
      return;
    }

    final newMessage = {
      "content": text,
      "files": files,
      "receiverId": receiverId.toString(),
      "senderId": id,
      "createdAt": DateTime.now().toIso8601String(),
    };

    if (text.trim().isNotEmpty || files.isNotEmpty) {
      _addSingleMessage(newMessage);
    }

    log("======================================");
    log("📤 SEND NURSE → PATIENT");
    log("receiverId: $receiverId");
    log("content: $text");
    log("files: $files");
    log("======================================");

    socket!.emitWithAck(
      "send-message",
      {
        "content": text,
        "files": files,
        "receiverId": receiverId,
      },
      ack: (response) {
        log("✅ Nurse → Patient Send ACK: $response");
      },
    );
  }

  // =====================================================
  // DISPOSE OLD SOCKET
  // =====================================================

  void _disposeOldSocket() {
    try {
      if (socket == null) return;

      if (currentNursePatientEvent != null) {
        socket!.off(currentNursePatientEvent!);
      }

      if (id != null && id!.isNotEmpty) {
        socket!.off("messages::$id");
      }

      socket!.off('connect');
      socket!.off('connect_error');
      socket!.off('disconnect');
      socket!.off('error');

      if (socket!.connected) {
        socket!.disconnect();
      }

      socket!.dispose();

      socket = null;

      log("♻️ Previous socket disposed");
    } catch (e) {
      log("⚠️ Socket dispose error: $e");
    }
  }

  // =====================================================
  // MANUAL DISCONNECT
  // =====================================================

  void disconnectSocket() {
    _disposeOldSocket();

    isConnected.value = false;
    isLoading.value = false;

    log("🔌 Socket manually disconnected");
  }

  // =====================================================
  // ON CLOSE
  // =====================================================

  @override
  void onClose() {
    disconnectSocket();
    super.onClose();
  }
}