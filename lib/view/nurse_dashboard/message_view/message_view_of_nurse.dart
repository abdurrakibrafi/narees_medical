// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_date_format.dart';
import 'package:restaurent_discount_app/common%20widget/not_found_widget.dart';
import 'package:restaurent_discount_app/uitilies/api/local_storage.dart';

import '../profile_view/controller/socket_controller.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/message_view/widget/chat_bubble_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/message_view/widget/chat_input_filed.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final SocketController _socketController = Get.put(SocketController());
  final StorageService _storageService = Get.put(StorageService());
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_socketController.isConnected.value) {
        _socketController.listenMessages();
        _socketController.initialEmit('');
      }

      ever(_socketController.isConnected, (connected) {
        if (connected) {
          _socketController.listenMessages();
          _socketController.initialEmit('');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final messages = _socketController.messages;
      final isLoading = _socketController.isLoading.value; // ✅
      final myId = _storageService.read<String>('id');

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Column(
            children: [
              CustomText(
                text: "Message",
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              if (isLoading)
                Text(
                  "Connecting...",
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: isLoading
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.grey.shade400,
                      strokeWidth: 2,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "Loading messages...",
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              )
                  : messages.isEmpty
                  ? NotFoundWidget(message: "No message found!")
                  : ListView.builder(
                reverse: true,
                itemCount: messages.length,
                padding: EdgeInsets.all(12),
                itemBuilder: (context, index) {
                  final msg = messages[messages.length - 1 - index];
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

            // ✅ Loading এর সময় input disabled
            IgnorePointer(
              ignoring: isLoading,
              child: AnimatedOpacity(
                opacity: isLoading ? 0.4 : 1.0,
                duration: Duration(milliseconds: 300),
                child: ChatInputField(
                  controller: _messageController,
                  onSend: () {
                    final text = _messageController.text.trim();
                    if (text.isEmpty) return;

                    _socketController.sendMessage(text);
                    _messageController.clear();
                  },
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      );
    });
  }
}