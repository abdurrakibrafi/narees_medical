// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:restaurent_discount_app/common%20widget/custom_app_bar_widget.dart';

class ChatDetailsPage extends StatefulWidget {
  final String name;
  const ChatDetailsPage({super.key, required this.name});

  @override
  State<ChatDetailsPage> createState() => _ChatDetailsPageState();
}

class _ChatDetailsPageState extends State<ChatDetailsPage> {
  final TextEditingController _messageController = TextEditingController();

  final ScrollController _scrollController = ScrollController();

  final ImagePicker _picker = ImagePicker();



  List<ChatMessage> messages = [
    ChatMessage(
      message: "Hello!",
      isMe: false,
    ),
    ChatMessage(
      message: "Hi, how are you?",
      isMe: true,
    ),
  ];



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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: widget.name,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final item = messages[index];

                return Align(
                  alignment:
                      item.isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 12,
                    ),
                    padding: item.imagePath == null
                        ? const EdgeInsets.all(14)
                        : const EdgeInsets.all(8),
                    constraints: const BoxConstraints(
                      maxWidth: 280,
                    ),
                    decoration: BoxDecoration(
                      color: item.isMe ? Colors.blue : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: item.imagePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            child: Image.file(
                              File(
                                item.imagePath!,
                              ),
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Text(
                            item.message ?? "",
                            style: TextStyle(
                              color: item.isMe ? Colors.white : Colors.black,
                            ),
                          ),
                  ),
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
                  onPressed: (){


                  },
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
                    onPressed: (){

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
        ],
      ),
    );
  }
}

class ChatMessage {
  final String? message;
  final String? imagePath;
  final bool isMe;

  ChatMessage({
    this.message,
    this.imagePath,
    required this.isMe,
  });
}
