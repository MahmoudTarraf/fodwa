import '../repositories/messages_repository.dart';
import '../entities/message_entity.dart';

class GetMessagesUseCase {
  final MessagesRepository repository;

  GetMessagesUseCase(this.repository);

  Future<List<MessageEntity>> call() async {
    return await repository.getMessages();
  }
}
