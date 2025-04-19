import 'package:project_neo/domain/entities/auth/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.name, required super.email});
  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['sub'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
    );
  }
}
