class Status {
  final String id;
  final String userName;
  final String userImage;
  final String statusText;
  final DateTime time;
  final bool isViewed;
  final bool isMyStatus;
  final StatusType type;

  Status({
    required this.id,
    required this.userName,
    required this.userImage,
    required this.statusText,
    required this.time,
    this.isViewed = false,
    this.isMyStatus = false,
    this.type = StatusType.text,
  });
}

enum StatusType {
  text,
  image,
  video,
}

class Channel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final int followers;
  late final bool isFollowing;
  final DateTime createdAt;

  Channel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.followers,
    this.isFollowing = false,
    required this.createdAt,
  });
}