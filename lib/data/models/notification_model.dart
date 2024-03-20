import 'package:intl/intl.dart';

class NotificationModel {
  late final int id;
  late final int notificationId;
  late final String creationDate;
  late final int recipientId;
  late final int senderId;
  late final String body;
  late final int type;
  late final String? title;
  late final String? readedAt;

  NotificationModel({
    required this.id,
    required this.notificationId,
    required this.creationDate,
    required this.recipientId,
    required this.senderId,
    required this.body,
    required this.type,
     this.title,
    this.readedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json["id"],
      notificationId: json["notification_id"],
      creationDate: DateFormat('M/d/y, hh:mm aa')
        .format(DateTime.parse(json['creationTime'])),
      recipientId: json["recipient_id"],
      senderId: json["sender_id"],
      body: json["body"],
      type: json["type"],
      title: json["title"],
      readedAt: json["readedAt"],
    );
  }
}

  