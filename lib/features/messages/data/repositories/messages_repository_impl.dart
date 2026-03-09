import '../../domain/entities/message_entity.dart';
import '../../domain/repositories/messages_repository.dart';
import '../models/message_model.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  @override
  Future<List<MessageEntity>> getMessages() async {
    // Return dummy data matching the Figma design for now
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      MessageModel(
        id: '1',
        senderName: 'Minna Basim Alnemnem',
        senderAvatar: 'assets/images/placeholder1.png', // Fallback to placeholder or initials
        lastMessageContext: 'sent a picture',
        timeElapsed: '5 hour',
        hasUnread: false,
      ),
      MessageModel(
        id: '2',
        senderName: 'Jamal Elhassan',
        senderAvatar: 'assets/images/placeholder2.png',
        lastMessageContext: 'shared a video',
        timeElapsed: '2 hours',
        hasUnread: true,
      ),
      MessageModel(
        id: '3',
        senderName: 'Jamal Alhussein',
        senderAvatar: 'assets/images/placeholder3.png',
        lastMessageContext: 'commented on your post',
        timeElapsed: '2 hours',
        hasUnread: false,
      ),

    ];
  }
}
