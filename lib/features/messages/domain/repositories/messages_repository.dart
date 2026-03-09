import '../entities/message_entity.dart';

abstract class MessagesRepository {
  Future<List<MessageEntity>> getMessages();
}
