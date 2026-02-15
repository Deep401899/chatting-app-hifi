class Community {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int memberCount;
  final bool isArchived;
  final bool isAdmin;
  final List<CommunityAnnouncement> announcements;
  final List<CommunityGroup> groups;
  final DateTime createdAt;

  Community({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.memberCount,
    this.isArchived = false,
    this.isAdmin = false,
    this.announcements = const [],
    this.groups = const [],
    required this.createdAt,
  });
}

class CommunityAnnouncement {
  final String id;
  final String title;
  final String content;
  final DateTime time;
  final String author;

  CommunityAnnouncement({
    required this.id,
    required this.title,
    required this.content,
    required this.time,
    required this.author,
  });
}

class CommunityGroup {
  final String id;
  final String name;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int unreadCount;
  final bool isMuted;

  CommunityGroup({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.lastMessageTime,
    this.unreadCount = 0,
    this.isMuted = false,
  });
}