class Chat {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isPinned;
  final bool isArchived;
  final bool isGroup;
  final String profileImage;
  final String phoneNumber;
  final bool isOnline;
  final List<Message> messages;

  Chat({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isPinned = false,
    this.isArchived = false,
    this.isGroup = false,
    this.profileImage = '',
    this.phoneNumber = '',
    this.isOnline = false,
    this.messages = const [],
  });
}

class Message {
  final String id;
  final String senderId;
  final String senderName;
  final String content;
  final DateTime timestamp;
  final bool isSent;
  final bool isDelivered;
  final bool isRead;
  final bool isMedia;
  final String? mediaUrl;
  final MessageType type;

  Message({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.content,
    required this.timestamp,
    this.isSent = true,
    this.isDelivered = false,
    this.isRead = false,
    this.isMedia = false,
    this.mediaUrl,
    this.type = MessageType.text,
  });
}

enum MessageType {
  text,
  image,
  video,
  audio,
  document,
}

