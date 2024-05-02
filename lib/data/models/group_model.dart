
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

