import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fodwa/core/utils/app_constants.dart';

import '../home_widgets/app_bar.dart';

class HomePageItem extends StatefulWidget {
  const HomePageItem({super.key});

  @override
  State<HomePageItem> createState() => _HomePageItemState();
}

class _HomePageItemState extends State<HomePageItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerBarrierDismissible: false,
      backgroundColor: Color(0xFFf5f5f5),

      extendBody: true,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,

        leading: null,
        toolbarHeight: AppConstants.h * 0.15,
        //0.0733
        leadingWidth: 0,
        titleSpacing: 0,

        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        elevation: 0,
        title: AppBarContent(),
      ),
      body: Column(children: [Container(color: Colors.grey)]),
    );
  }
}
