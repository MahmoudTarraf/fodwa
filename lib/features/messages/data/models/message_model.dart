import '../../domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({
    required super.id,
    required super.senderName,
    required super.senderAvatar,
    required super.lastMessageContext,
    required super.timeElapsed,
    required super.hasUnread,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'],
      senderName: json['senderName'],
      senderAvatar: json['senderAvatar'],
      lastMessageContext: json['lastMessageContext'],
      timeElapsed: json['timeElapsed'],
      hasUnread: json['hasUnread'] ?? false,
    );
  }
}
