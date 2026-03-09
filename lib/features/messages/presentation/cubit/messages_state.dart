import '../../domain/entities/message_entity.dart';

abstract class MessagesState {}

class MessagesInitial extends MessagesState {}

class MessagesLoading extends MessagesState {}

class MessagesLoaded extends MessagesState {
  final List<MessageEntity> messages;
  MessagesLoaded(this.messages);
}

class MessagesEmpty extends MessagesState {}

class MessagesError extends MessagesState {
  final String message;
  MessagesError(this.message);
}
