
class GroupModel {
  late int id;
  late String name, about, creationDate, creationTime;
  late int membersCount;

  GroupModel.fromJson(dynamic json) {
    id = json["id"];
    name = json["group_name"];
    about=json['group_about'];
    membersCount = json['members_count'];
    creationDate = json['creationTime'].toString().split(' ')[0];
        creationTime = json['creationTime'].toString().split(' ')[1];

  }
}

class GroupMemberModel {
  late int id;
  late int memberId;
  late String memberNickname, memberUsername;

  GroupMemberModel({
    required this.id,
    required this.memberId,
    required this.memberNickname,
    required this.memberUsername,
  });

  factory GroupMemberModel.fromJson(dynamic json) {
    return GroupMemberModel(
      id: json["id"],
      memberId: json["member_id"],
      memberNickname: json["member_nick_name"],
      memberUsername: json['member_username'],
    );
  }
}
