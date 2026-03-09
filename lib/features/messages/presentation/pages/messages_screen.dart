import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fodwa/core/utils/app_colors.dart';
import 'package:fodwa/core/utils/app_constants.dart';
import 'package:fodwa/core/utils/app_images.dart';
import 'package:fodwa/core/utils/responsive_helper.dart';
import 'package:fodwa/features/messages/presentation/cubit/messages_cubit.dart';
import 'package:fodwa/features/messages/presentation/cubit/messages_state.dart';
import 'package:fodwa/features/messages/data/repositories/messages_repository_impl.dart';
import 'package:fodwa/features/messages/domain/usecases/get_messages_usecase.dart';
import 'package:flutter/services.dart';
import 'package:fodwa/features/messages/presentation/pages/chat_details_screen.dart';
import 'package:fodwa/features/messages/presentation/widgets/messages_app_bar.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConstants.initSize(context);

    return BlocProvider(
      create: (context) =>
          MessagesCubit(GetMessagesUseCase(MessagesRepositoryImpl()))
            ..loadMessages(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,

          leading: null,
          toolbarHeight: AppConstants.h * 0.10,
          //0.0733
          leadingWidth: 0,
          titleSpacing: 0,

          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.white,
          elevation: 0,
          title: MessagesAppBar(),
        ),
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.w * 0.043,
                vertical: AppConstants.h * 0.029,
              ),
              child: Container(
                height: ResponsiveHelper.proportionalHeight(context, 44),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFE5E7EB),
                    width: 1.5,
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: ResponsiveHelper.proportionalWidth(context, 16),
                    ),
                    Icon(
                      Icons.search,
                      color: AppColors.primaryColor,
                      size: ResponsiveHelper.proportionalWidth(context, 20),
                    ),
                    SizedBox(
                      width: ResponsiveHelper.proportionalWidth(context, 12),
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(
                            color: const Color(0xFF9CA3AF),
                            fontSize: ResponsiveHelper.proportionalWidth(
                              context,
                              14,
                            ),
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: ResponsiveHelper.proportionalWidth(
                            context,
                            14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: BlocBuilder<MessagesCubit, MessagesState>(
                builder: (context, state) {
                  if (state is MessagesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MessagesError) {
                    return Center(child: Text(state.message));
                  } else if (state is MessagesEmpty) {
                    return _buildEmptyState(context);
                  } else if (state is MessagesLoaded) {
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: state.messages.length,

                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: AppConstants.w * 0.043,
                            vertical: AppConstants.h * 0.005,
                          ),
                          leading: CircleAvatar(
                            radius: ResponsiveHelper.proportionalWidth(
                              context,
                              24,
                            ),
                            backgroundImage: AssetImage(AppImages.avatar),
                           
                          ),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                message.senderName,
                                style: TextStyle(
                                  fontSize: ResponsiveHelper.proportionalWidth(
                                    context,
                                    14,
                                  ),
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                message.timeElapsed,
                                style: TextStyle(
                                  fontSize: ResponsiveHelper.proportionalWidth(
                                    context,
                                    12,
                                  ),
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.dividerGray,
                                ),
                              ),
                            ],
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(
                              top: ResponsiveHelper.proportionalHeight(
                                context,
                                4,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  message.lastMessageContext,
                                  style: TextStyle(
                                    fontSize:
                                        ResponsiveHelper.proportionalWidth(
                                          context,
                                          14,
                                        ),
                                    fontWeight: FontWeight.w400,
                                    color:message.hasUnread? AppColors.textPrimary: AppColors.dividerGray,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                if (message.hasUnread)
                                  Container(
                                    width: ResponsiveHelper.proportionalWidth(
                                      context,
                                      8,
                                    ),
                                    height: ResponsiveHelper.proportionalWidth(
                                      context,
                                      8,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: AppColors.primaryColor,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ChatDetailsScreen(peer: message),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: ResponsiveHelper.proportionalWidth(context, 120),
            height: ResponsiveHelper.proportionalWidth(context, 120),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.chat_bubble_outline,
                size: ResponsiveHelper.proportionalWidth(context, 60),
                color: Colors.grey.shade300,
              ),
            ),
          ),
          SizedBox(height: ResponsiveHelper.proportionalHeight(context, 16)),
          Text(
            'There is no chat',
            style: TextStyle(
              fontSize: ResponsiveHelper.proportionalWidth(context, 18),
              fontWeight: FontWeight.w500,
              color: const Color(0xFF9CA3AF),
            ),
          ),
        ],
      ),
    );
  }
}
