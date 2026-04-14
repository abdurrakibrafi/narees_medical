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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLoading = _controller.isLoading.value;

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          forceMaterialTransparency: true,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: CustomText(
            text: "Chat with Admin",
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 10.h),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ChatBubble(
                      message: "dgdg",
                      time: "dfgf",
                      isMe: true,
                    );
                  },
                ),
              ),
              ChatInputField(
                controller: _messageController,
                onSend: () {},
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      );
    });
  }
}
