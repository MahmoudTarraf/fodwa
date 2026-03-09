// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/core/utils/responsive_helper.dart';
import 'package:fodwa/features/messages/domain/entities/message_entity.dart';

class ChatDetailsMessage {
  final String text;
  final String time;
  final bool isMe;

  ChatDetailsMessage({
    required this.text,
    required this.time,
    required this.isMe,
  });
}

class ChatDetailsScreen extends StatefulWidget {
  final MessageEntity peer;

  const ChatDetailsScreen({Key? key, required this.peer}) : super(key: key);

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  final TextEditingController _messageController = TextEditingController();
  bool _hasText = false;

  late List<dynamic> _chatItems;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {
        _hasText = _messageController.text.isNotEmpty;
      });
    });

    // Dummy data generation based on whether we want empty or filled.
    // Let's assume if it has unread it's filled for demo, or we can just randomly decide.
    // Figma shows Jamal Elhassan has history. So let's hardcode history for Jamal Elhassan for exact Figma matching, and Empty for others.
    if (widget.peer.senderName == 'Jamal Elhassan') {
      _chatItems = [
        "5/5/2025",
        ChatDetailsMessage(
          text:
              "It's price is \$1,200, but we have a special offer today for \$1,150.",
          time: "5:00 AM",
          isMe: false,
        ),
        ChatDetailsMessage(
          text: "I think 256GB will be enough. How much does it cost?",
          time: "5:00 AM",
          isMe: true,
        ),
        "Today",
        ChatDetailsMessage(
          text:
              "It's price is \$1,200, but we have a special offer today for \$1,150.",
          time: "5:00 AM",
          isMe: false,
        ),
        ChatDetailsMessage(
          text: "It's price is \$1,200,",
          time: "5:00 AM",
          isMe: false,
        ),
        ChatDetailsMessage(text: "I think", time: "5:00 AM", isMe: true),
        ChatDetailsMessage(
          text: "I think 256GB will be enough. How much does it cost?",
          time: "5:00 AM",
          isMe: true,
        ),
      ];
    } else {
      _chatItems = [];
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppConstants.initSize(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Colors.black.withOpacity(0.1),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: ResponsiveHelper.proportionalWidth(context, 24),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: ResponsiveHelper.proportionalWidth(context, 20),
              backgroundImage: AssetImage(AppImages.avatar),
            ),
            SizedBox(width: ResponsiveHelper.proportionalWidth(context, 12)),
            Expanded(
              child: Text(
                widget.peer.senderName,
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: ResponsiveHelper.proportionalWidth(context, 16),
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          Image.asset(
            AppImages.threeDots,
            height: ResponsiveHelper.proportionalHeight(context, 30),
          ),
          SizedBox(width: ResponsiveHelper.proportionalWidth(context, 8)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _chatItems.isEmpty ? _buildEmptyState() : _buildChatList(),
          ),
          _buildBottomInput(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Image.asset(AppImages.noChat)],
      ),
    );
  }

  Widget _buildChatList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.proportionalWidth(context, 16),
        vertical: ResponsiveHelper.proportionalHeight(context, 16),
      ),
      itemCount: _chatItems.length,
      itemBuilder: (context, index) {
        final item = _chatItems[index];

        if (item is String) {
          // Date Divider
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: ResponsiveHelper.proportionalHeight(context, 16),
            ),
            child: Center(
              child: Text(
                item,
                style: TextStyle(
                  fontSize: ResponsiveHelper.proportionalWidth(context, 12),
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF4B5563),
                ),
              ),
            ),
          );
        } else if (item is ChatDetailsMessage) {
          return _buildChatBubble(item);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildChatBubble(ChatDetailsMessage message) {
    bool isMe = message.isMe;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: ResponsiveHelper.proportionalHeight(context, 12),
        ),
        constraints: BoxConstraints(
          maxWidth: ResponsiveHelper.proportionalWidth(context, 280),
        ),
        padding: EdgeInsets.all(
          ResponsiveHelper.proportionalWidth(context, 16),
        ),
        decoration: BoxDecoration(
          color: isMe
              ? Colors.white
              : AppColors.pColor, // Red for other, White for me
          border: isMe
              ? Border.all(color: const Color(0xFFF3F4F6), width: 1.5)
              : null,
          boxShadow: isMe
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
              ResponsiveHelper.proportionalWidth(context, 12),
            ),
            topRight: Radius.circular(
              ResponsiveHelper.proportionalWidth(context, 12),
            ),
            bottomLeft: Radius.circular(
              isMe ? ResponsiveHelper.proportionalWidth(context, 12) : 0,
            ),
            bottomRight: Radius.circular(
              isMe ? 0 : ResponsiveHelper.proportionalWidth(context, 12),
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(
                fontSize: ResponsiveHelper.proportionalWidth(context, 14),
                fontWeight: FontWeight.w400,
                color: isMe ? const Color(0xFF1F2937) : Colors.white,
                height: 1.4,
              ),
            ),
            SizedBox(height: ResponsiveHelper.proportionalHeight(context, 8)),
            Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Text(
                message.time,
                style: TextStyle(
                  fontSize: ResponsiveHelper.proportionalWidth(context, 12),
                  fontWeight: FontWeight.w400,
                  color: isMe
                      ? const Color(0xFF6B7280)
                      : Colors.white.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomInput() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.proportionalWidth(context, 16),
        vertical: ResponsiveHelper.proportionalHeight(context, 16),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: const Color(0xFFF3F4F6), width: 1.5),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: ResponsiveHelper.proportionalHeight(context, 48),
                  maxHeight: ResponsiveHelper.proportionalHeight(context, 120),
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFD1D5DB), width: 1),
                  borderRadius: BorderRadius.circular(
                    ResponsiveHelper.proportionalWidth(context, 8),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: ResponsiveHelper.proportionalWidth(context, 16),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(
                          fontSize: ResponsiveHelper.proportionalWidth(
                            context,
                            14,
                          ),
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Write a message',
                          hintStyle: TextStyle(
                            fontSize: ResponsiveHelper.proportionalWidth(
                              context,
                              14,
                            ),
                            color: const Color(0xFF9CA3AF),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: ResponsiveHelper.proportionalHeight(
                              context,
                              14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (!_hasText) ...[
                      InkWell(
                        onTap: () {},
                        child: Image.asset(AppImages.gallery),
                      ),
                      SizedBox(
                        width: ResponsiveHelper.proportionalWidth(context, 12),
                      ),
                      // Link/Attachment Icon
                      IconButton(
                        icon: Icon(
                          Icons.link,
                          color: const Color(0xFF4B5563),
                          size: ResponsiveHelper.proportionalWidth(context, 24),
                        ),
                        onPressed: () {},
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                      SizedBox(
                        width: ResponsiveHelper.proportionalWidth(context, 16),
                      ),
                    ] else ...[
                      // Send Icon
                      InkWell(
                        onTap: () {
                          // Send message logic
                          setState(() {
                            _chatItems.add(
                              ChatDetailsMessage(
                                text: _messageController.text,
                                time: 'Now',
                                isMe: true,
                              ),
                            );
                            _messageController.clear();
                          });
                        },
                        child: Padding(
                          padding: EdgeInsetsGeometry.only(
                            right: ResponsiveHelper.proportionalWidth(
                              context,
                              16,
                            ),
                          ),
                          child: Image.asset(
                            AppImages.sendMessageButton,

                            width: ResponsiveHelper.proportionalWidth(
                              context,
                              30,
                            ),
                            height: ResponsiveHelper.proportionalHeight(
                              context,
                              30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
