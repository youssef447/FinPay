class TicketModel {
  late final int id;
  late final int? userId;
    String? createdAt;
  late final String state;
  late List<TicketReplyModel> replies = [];

  TicketModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    
    state = json["state"];
    createdAt = json["creationTime"];
    if (json['replies'] != null) {
      replies = (json["replies"] as List<dynamic>).map((element) {
        return TicketReplyModel.fromJson(element);
      }).toList();
    }
  }
}

class TicketReplyModel {
  late final int id;
  late final int? userId;
  late final int ticketId;
  late final int sender;
  late final String message;
String? createdAt;
  TicketReplyModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    userId = json["user_id"];
    ticketId = json["ticket_id"];
    sender = json["sender"];
    message = json["message"];
    createdAt = json["created_at"];
  }
}
