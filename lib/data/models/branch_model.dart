class BranchModel {
  late final String lat, long, branchName, address, createdAt;

  BranchModel.fromJson(Map<String, dynamic> json) {
    lat = json["lat"];
    long = json["lon"];

    branchName = json["branch_name"];

    address = json["address"];

    createdAt = json["created_at"];
  }
}
