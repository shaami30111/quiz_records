class AuthModel {
  String? email;
  String? userRole;

  AuthModel({this.email, this.userRole});

  AuthModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    userRole = json['userRole'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['userRole'] = userRole;
    return data;
  }
}
