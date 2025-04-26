// ignore_for_file: prefer_final_fields, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/message_view/widget/chat_bubble_widget.dart';
import 'package:restaurent_discount_app/view/nurse_dashboard/message_view/widget/chat_input_filed.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Andrew Ainsley",
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          )
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
            SizedBox(height: 30.h)
          ],
        ),
      ),
    );
  }
}
