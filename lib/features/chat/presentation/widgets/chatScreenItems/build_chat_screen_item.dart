// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_constants.dart';

import '../../../data/models/build_chat_message.dart';
import '../chaWidgets/build_appbar.dart';
import '../chaWidgets/build_chat_question.dart';
import '../chaWidgets/build_send_message.dart' show BuildSendMessage;
import '../chaWidgets/chat_widget.dart';

class BuildChatScreenItem extends StatefulWidget {
  const BuildChatScreenItem({super.key});

  @override
  State<BuildChatScreenItem> createState() => _BuildChatScreenItemState();
}

class _BuildChatScreenItemState extends State<BuildChatScreenItem> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "Hello! 👋 I'm your AI shopping assistant. I'm here to help you 24/7 with any questions about orders, shipping, returns, or anything else!\nHow can I assist you today?",
      isBot: true,
      time: "5:00 AM",
    ),
    ChatMessage(
      text: "I think 256GB will be enough. How much does it cost?",
      isBot: false,
      time: "5:00 AM",
    ),
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            text: _messageController.text,
            isBot: false,
            time: "5:00 AM",
          ),
        );
      });
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // init size (375 × 812)
    AppConstants.initSize(context);

    return Scaffold(
      backgroundColor: AppColors.screenBg,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Color(0XFFFFFFFF),
        toolbarHeight: 70,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: AppConstants.w * 0.064, // 24 / 375
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        titleSpacing: 1,
        title: const BuildChatAppbar(),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: const Color(0xFFECF1F6).withOpacity(0.05),
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.w * 0.064,
              vertical: AppConstants.h * 0.0150,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: AppConstants.h * 0.017, // 14 / 812
                ),
                Text(
                  'Quick questions:',
                  style: TextStyle(
                    fontSize: AppConstants.w * 0.0373, // 14 / 375
                    color: const Color(0xFF434E58),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: AppConstants.h * 0.015, // 12 / 812
                ),
                Wrap(
                  spacing: AppConstants.w * 0.021, // 8 / 375
                  runSpacing: AppConstants.w * 0.021, // 8 / 375
                  children: [
                    QuickQuestionButton(title: 'Track my order', onTap: () {}),
                    QuickQuestionButton(
                      title: 'Payment methods',
                      width: AppConstants.w * 0.4, // already responsive
                      onTap: () {},
                    ),
                    QuickQuestionButton(title: 'Shipping info', onTap: () {}),
                    QuickQuestionButton(title: 'Return policy', onTap: () {}),
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Color(0XFFCED5DA),
            width: double.infinity,
            height: 0.6,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(
                AppConstants.w * 0.043, // 16 / 375
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: _messages[index]);
              },
            ),
          ),
          BuildSendMessage(
            onTap: _sendMessage,
            textEditingController: _messageController,
          ),
        ],
      ),
    );
  }
}
