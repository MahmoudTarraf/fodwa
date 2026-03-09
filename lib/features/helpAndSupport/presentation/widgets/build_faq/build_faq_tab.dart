import 'package:flutter/material.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/features/helpAndSupport/presentation/widgets/build_faq/build_faq_list.dart';

import 'build_faq_search.dart' show BuildFaqSearch;

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    /// init size (375 × 812)
    AppConstants.initSize(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.w * 0.064),
      child: Column(
        children: [
          /// top spacing
          SizedBox(
            height: AppConstants.h * 0.0197, // 16 / 812
          ),

          /// Search
          BuildFaqSearch(searchController: _searchController),

          /// spacing between search & list
          SizedBox(
            height: AppConstants.h * 0.0197, // 16 / 812
          ),

          /// FAQ List
          const BuildFaqList(),
        ],
      ),
    );
  }
}
