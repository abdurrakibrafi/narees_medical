// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_workers/rx_workers.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';

import '../common widget/custom text/custom_text_widget.dart';
import '../common widget/custom_date_format.dart';
import '../uitilies/api/local_storage.dart';
import 'nurse_dashboard/message_view/widget/chat_bubble_widget.dart';
import 'nurse_dashboard/profile_view/controller/socket_controller.dart';

class ChatDetailsPage extends StatefulWidget {
  final String name;
  final String receiverId;

  const ChatDetailsPage({
    super.key,
    required this.name,
    required this.receiverId, // ✅ Added receiverId
  });

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final ScrollController _scrollController = ScrollController();

  final SocketController _socketController = Get.put(SocketController());

  final StorageService _storageService = Get.put(StorageService());

  final TextEditingController _messageController = TextEditingController();

  final ImagePicker _picker = ImagePicker();

  void scrollToBottom() {
    Future.delayed(
      const Duration(milliseconds: 200),
      () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    // ✅ Print receiver ID
    print("Receiver ID: ${widget.receiverId}");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_socketController.isConnected.value) {
        _socketController.listenMessages();
      }
    });

    ever(_socketController.isConnected, (connected) {
      if (connected) {
        _socketController.listenMessages();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final myId = _storageService.read<String>('id');
      print("myId: $myId");

      print("Receiver ID: ${widget.receiverId}");

      // ✅ Filter messages between me and receiver only
      final messages = _socketController.messages.where((msg) {
        final senderId = msg['senderId']?.toString();
        final recipientId =
            msg['recipientId']?.toString(); // change key if needed

        return (senderId == myId && recipientId == widget.receiverId) ||
            (senderId == widget.receiverId && recipientId == myId);
      }).toList();

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: CustomText(
            text: widget.name,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: messages.isEmpty
                  ? Center(child: Text("No messages yet"))
                  : ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      padding: EdgeInsets.all(12),
                      itemBuilder: (context, index) {
                        final msg = messages[index];

                        final isMe =
                            msg['senderId']?.toString() == myId?.toString();

                        return ChatBubble(
                          message: msg['content'] ?? '',
                          time: CustomDateFormatter.formatDateTime(
                              msg['createdAt'] ?? DateTime.now()),
                          isMe: isMe,
                        );
                      },
                    ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                    color: Colors.black12,
                  ),
                ],
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.image,
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Type message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  CircleAvatar(
                    child: IconButton(
                      onPressed: () {
                        final text = _messageController.text.trim();
                        if (text.isEmpty) return;

                        _socketController.sendMessageFromNurseToPatient(
                            text, widget.receiverId);

                        _messageController.clear();

                        print("Message sent: $text");
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      );
    });
  }
}
