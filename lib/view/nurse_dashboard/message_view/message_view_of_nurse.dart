// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom%20text/custom_text_widget.dart';

import 'controller/chat_list_controller.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/message_view/widget/chat_bubble_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/message_view/widget/chat_input_filed.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GetChatListController _controller = Get.put(GetChatListController());

  TextEditingController _messageController = TextEditingController();
  List<Map<String, dynamic>> messages = [
    {"text": "What's up, dude?", "time": "12:01", "isMe": false},
    {
      "text":
          "Good, I finally finished this work, starting to work on the next one",
      "time": "12:01",
      "isMe": true
    },
    {"text": "Hey, guys, all is good 😏", "time": "12:01", "isMe": false},
    {"text": "Nice👌", "time": "12:01", "isMe": true},
    {"text": "Hey, all is good 😏", "time": "12:01", "isMe": false},
    {"text": "Hey, guys, all is good 😏", "time": "12:01", "isMe": false},
  ];

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add({
          "text": _messageController.text,
          "time": "12:01",
          "isMe": true,
        });
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = _controller.isLoading.value;

      String title = "Loading...";
      String? profileImageUrl;

      if (!isLoading &&
          _controller.nurseData.value.data != null &&
          _controller.nurseData.value.data!.isNotEmpty) {
        final participant =
            _controller.nurseData.value.data![0].participants[0];
        title = participant.fullname ?? "Unknown";
        profileImageUrl = participant.profilePicture;
      }

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (profileImageUrl != null && profileImageUrl.isNotEmpty)
                CircleAvatar(
                  radius: 18.r,
                  backgroundImage: NetworkImage(profileImageUrl),
                  backgroundColor: Colors.grey[200],
                )
              else
                CircleAvatar(
                  radius: 18.r,
                  backgroundColor: Colors.grey[200],
                  child: Icon(Icons.person, color: Colors.grey),
                ),
              SizedBox(width: 10.w),
              Flexible(
                child: CustomText(
                  text: title,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.h),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      message: messages[index]["text"],
                      time: messages[index]["time"],
                      isMe: messages[index]["isMe"],
                    );
                  },
                ),
              ),
              ChatInputField(
                controller: _messageController,
                onSend: _sendMessage,
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      );
    });
  }
}
