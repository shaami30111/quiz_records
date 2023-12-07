class AuthModel {
  String? email;
  Role? role;

  AuthModel({this.email, this.role});

  AuthModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}

class Role {
  bool? admin;
  bool? moderator;

  Role({this.admin, this.moderator});

  Role.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    moderator = json['moderator'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['admin'] = admin;
    data['moderator'] = moderator;
    return data;
  }
}
