import 'package:flutter/material.dart';
import '../../../../../core/utils/app_constants.dart';

// ignore: must_be_immutable
class BuildSendMessage extends StatefulWidget {
  BuildSendMessage({
    super.key,
    required this.onTap,
    required this.textEditingController,
  });

  TextEditingController textEditingController;
  Function()? onTap;

  @override
  State<BuildSendMessage> createState() => _BuildSendMessageState();
}

class _BuildSendMessageState extends State<BuildSendMessage> {
  @override
  Widget build(BuildContext context) {
    // init size (375 × 812)
    AppConstants.initSize(context);

    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.w * 0.064, // 16 / 375
        vertical: AppConstants.h * 0.015, // 12 / 812
      ),
      child: SafeArea(
        child: Container(
          height: AppConstants.h * 0.054, // 44 / 812
          width: AppConstants.w * 0.872, // 327 / 375
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFD1D8DD),
              width: AppConstants.w * 0.0027, // 1 / 375
            ),
            borderRadius: BorderRadius.circular(
              AppConstants.w * 0.021, // 8 / 375
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.w * 0.032, // 12 / 375
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: widget.textEditingController,
                    decoration: InputDecoration(
                      hintText: 'message',
                      hintStyle: TextStyle(
                        color: const Color(0xFFE3E9ED),
                        fontSize: AppConstants.w * 0.048, // 18 / 375
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: AppConstants.w * 0.053, // 20 / 375
                        vertical: AppConstants.h * 0.012, // 10 / 812
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: AppConstants.w * 0.032, // 12 / 375
                ),
                Image.asset(
                  AppConstants.iconsUrl + "sendM.png",
                  fit: BoxFit.fill,
                  width: AppConstants.w * 0.085, // already responsive
                  height: AppConstants.h * 0.039, // already responsive
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
