class Call {
  final String id;
  final String contactName;
  final String contactImage;
  final String phoneNumber;
  final DateTime callTime;
  final CallType type;
  final CallDirection direction;
  final Duration duration;
  final bool isMissed;
  final bool isVideo;
  final bool isGroupCall;

  Call({
    required this.id,
    required this.contactName,
    required this.contactImage,
    required this.phoneNumber,
    required this.callTime,
    required this.type,
    required this.direction,
    required this.duration,
    this.isMissed = false,
    this.isVideo = false,
    this.isGroupCall = false,
  });
}

enum CallType {
  incoming,
  outgoing,
  missed,
}

enum CallDirection {
  incoming,
  outgoing,
}