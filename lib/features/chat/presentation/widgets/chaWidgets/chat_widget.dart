import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/core/utils/app_constants.dart';

import '../../../data/models/build_chat_message.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // init size (375 × 812)
    AppConstants.initSize(context);

    return Padding(
      padding: EdgeInsets.only(
        bottom: AppConstants.h * 0.020, // 16 / 812
        right: AppConstants.w * 0.027, // 10 / 375
        left: AppConstants.w * 0.027, // 10 / 375
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: message.isBot
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          if (message.isBot) ...[
            Container(
              width: AppConstants.w * 0.107, // 40 / 375
              height: AppConstants.w * 0.107, // 40 / 375
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: Image.asset(
                AppImages.bot,
                width: AppConstants.w * 0.064, // 24 / 375
              ),
            ),
            SizedBox(
              width: AppConstants.w * 0.021, // 8 / 375
            ),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: message.isBot
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Material(
                  borderRadius: BorderRadius.circular(
                    AppConstants.w * 0.061, // 23 / 375
                  ),
                  child: Container(
                    padding: EdgeInsets.all(
                      AppConstants.w * 0.043, // 16 / 375
                    ),
                    width: message.isBot
                        ? AppConstants.w * 0.8
                        : double.infinity,
                    decoration: BoxDecoration(
                      color: message.isBot
                          ? AppColors.primaryColor
                          : Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          message.isBot
                              ? AppConstants.w * 0.0
                              : AppConstants.w * 0.021,
                        ),
                        topRight: Radius.circular(
                          message.isBot
                              ? AppConstants.w * 0.021
                              : AppConstants.w * 0.0,
                        ),
                        bottomLeft: Radius.circular(
                          message.isBot
                              ? AppConstants.w *
                                    0.021 // 8 / 375
                              : AppConstants.w * 0.021,
                        ),
                        bottomRight: Radius.circular(
                          message.isBot
                              ? AppConstants.w *
                                    0.021 // 8 / 375
                              : AppConstants.w * 00.021, // 8 / 375
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: message.isBot
                          ? CrossAxisAlignment.start
                          : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.text,
                          style: TextStyle(
                            fontSize: AppConstants.w * 0.032, // 12 / 375
                            fontWeight: FontWeight.w500,
                            color: message.isBot
                                ? const Color(0xFFD1D8DD)
                                : Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: AppConstants.h * 0.005, // 4 / 812
                        ),
                        Row(
                          mainAxisAlignment: message.isBot
                              ? MainAxisAlignment.start
                              : MainAxisAlignment.end,
                          children: [
                            Text(
                              message.time,
                              style: TextStyle(
                                fontSize: AppConstants.w * 0.032, // 12 / 375
                                color: message.isBot
                                    ? const Color(0xFFA1A8AA)
                                    : const Color(0xFFA1A8AA),
                              ),
                            ),
                          ],
                        ),
                      ],
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
