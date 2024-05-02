
class MemberModel {
  late int id;
  late int memberId;
  late String memberNickname, memberUsername;

  MemberModel({
    required this.id,
    required this.memberId,
    required this.memberNickname,
    required this.memberUsername,
  });

  factory MemberModel.fromJson(dynamic json) {
    return MemberModel(
      id: json["id"],
      memberId: json["member_id"],
      memberNickname: json["member_nick_name"],
      memberUsername: json['member_username'],
    );
  }
}