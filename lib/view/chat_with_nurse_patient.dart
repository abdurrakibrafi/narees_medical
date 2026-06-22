// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:restaurent_discount_app/common%20widget/custom_date_format.dart';
import 'package:restaurent_discount_app/uitilies/api/local_storage.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/message_view/widget/chat_bubble_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/message_view/widget/chat_input_filed.dart';
import 'nurse_dashboard/message_view/controller/upload_image_controller.dart';
import 'nurse_dashboard/profile_view/controller/socket_controller.dart';

class ChatDetailsPage extends StatefulWidget {
  final String name;
  final String email;
  final String receiverId;

  const ChatDetailsPage(
      {super.key,
      required this.name,
      required this.email,
      required this.receiverId});

  @override
  _ChatDetailsPageState createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final SocketController _socketController = Get.put(SocketController());
  final StorageService _storageService = Get.put(StorageService());
  final TextEditingController _messageController = TextEditingController();
  final UploadImageController _uploadController =
      Get.put(UploadImageController());

  List<File> _selectedImages = [];

  @override
  void initState() {
    super.initState();

    final myId = _storageService.read<String>('id');
    print("myId for message on chat with nurse: $myId");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_socketController.isConnected.value) {
        _socketController.listenMessagesOfNursePatient(myId!);
        _socketController.initialEmit(widget.receiverId);
        print("✅ Initial Emit called for receiverId: ${widget.receiverId}");
      }

      ever(_socketController.isConnected, (connected) {
        if (connected) {
          _socketController.listenMessagesOfNursePatient(myId!);
          _socketController.initialEmit(widget.receiverId);
          print(
              "✅ Reconnected — Emit called for receiverId: ${widget.receiverId}");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final messages = _socketController.messagesOfNursePatient;
      final isLoading = _socketController.isLoading.value;
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
                text: widget.email,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
              // ✅ Connecting indicator
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
                  // ✅ Loading UI
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
                      ? Center(child: Text("No messages yet"))
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

            IgnorePointer(
              ignoring: isLoading,
              child: AnimatedOpacity(
                opacity: isLoading ? 0.4 : 1.0,
                duration: Duration(milliseconds: 300),
                child: ChatInputField(
                  allowMultipleImages: true,
                  allowImageUpload: true,
                  controller: _messageController,
                  onImagesSelected: (images) {
                    _selectedImages = images;
                  },
                  onSend: () async {
                    final text = _messageController.text.trim();
                    if (text.isEmpty && _selectedImages.isEmpty) return;

                    List<String> fileUrls = [];

                    if (_selectedImages.isNotEmpty) {
                      fileUrls = await _uploadController.uploadImages(
                        files: _selectedImages,
                      );
                      print("✅ Uploaded URLs: $fileUrls");
                    }

                    _socketController.sendMessageFromNurseToPatient(
                      text,
                      widget.receiverId,
                      files: fileUrls,
                    );

                    _messageController.clear();
                    _selectedImages.clear();
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
