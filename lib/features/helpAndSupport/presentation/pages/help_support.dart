import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/supportScreenItem/support_screen_item.dart';

class HelpAndSupport extends StatefulWidget {

  const HelpAndSupport({super.key});

  @override
  State<HelpAndSupport> createState() => _HelpAndSupportState();
}

class _HelpAndSupportState extends State<HelpAndSupport> {
  @override
  Widget build(BuildContext context) {
    return HelpSupportScreenItem();
  }
}
