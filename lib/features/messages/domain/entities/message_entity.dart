class MessageEntity {
  final String id;
  final String senderName;
  final String senderAvatar;
  final String lastMessageContext;
  final String timeElapsed;
  final bool hasUnread;

  MessageEntity({
    required this.id,
    required this.senderName,
    required this.senderAvatar,
    required this.lastMessageContext,
    required this.timeElapsed,
    required this.hasUnread,
  });
}
