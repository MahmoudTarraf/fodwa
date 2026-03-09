import 'package:flutter/material.dart';

import '../../../../../core/utils/app_constants.dart' show AppConstants;
import '../../../data/models/build_faq_model.dart';

class BuildFaqList extends StatefulWidget {
  const BuildFaqList({super.key});

  @override
  State<BuildFaqList> createState() => _BuildFaqListState();
}

class _BuildFaqListState extends State<BuildFaqList> {
  int? _expandedIndex = 0; // First item is expanded by default

  @override
  Widget build(BuildContext context) {
    /// init size (375 × 812)
    AppConstants.initSize(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: AppConstants.h * 0.7, // كما هو (already responsive)
            child: ListView.builder(
              itemCount: faqItems.length,
              itemBuilder: (context, index) {
                final isExpanded = _expandedIndex == index;

                return Padding(
                  padding: EdgeInsets.only(
                    bottom: AppConstants.h * 0.0148, // 12 / 812
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppConstants.w * 0.0213, // 8 / 375
                      ),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        width: AppConstants.w * 0.00267, // 1 / 375
                      ),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _expandedIndex = isExpanded ? null : index;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(
                              AppConstants.w * 0.0427, // 16 / 375
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    faqItems[index].question,
                                    style: TextStyle(
                                      fontSize:
                                          AppConstants.w * 0.0373, // 14 / 375
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xFF171725),
                                    ),
                                  ),
                                ),
                                Icon(
                                  isExpanded
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: const Color(0xFF6B7280),
                                  size: AppConstants.w * 0.0427, // 16 / 375
                                ),
                              ],
                            ),
                          ),
                        ),

                        if (isExpanded)
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.fromLTRB(
                              AppConstants.w * 0.0427, // 16 / 375
                              0,
                              AppConstants.w * 0.0427, // 16 / 375
                              AppConstants.h * 0.0197, // 16 / 812
                            ),
                            child: Text(
                              faqItems[index].answer,
                              style: TextStyle(
                                fontSize: AppConstants.w * 0.032, // 12 / 375
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF364153),
                                letterSpacing: 0,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
