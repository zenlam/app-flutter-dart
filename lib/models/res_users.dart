class ResUsersList {
  List<ResUsers> users;

  ResUsersList({this.users});

  int getLength() {
    return users.length;
  }

  ResUsersList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      users = new List<ResUsers>();
      json['data'].forEach((user) {
        users.add(new ResUsers.fromJson(user));
      });
    }
  }
}

class ResUsers {
  // Model Information
  static String modelName = "res.users";
  static List<String> fields = ["name"];

  // Model Definition
  int id;
  String name;

  // Constructor
  ResUsers({this.id, this.name});

  // Methods
  ResUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}
