import 'package:vazifa/data/models/role_model.dart';

class UserModel {
  int id;
  String name;
  String? email;
  String? phone;
  String? photo;
  int role;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  RoleModel? roleM;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    required this.photo,
    required this.role,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.roleM,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photo: json['photo'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      role: json['role_id'],
      roleM: RoleModel.fromJson(json['role']),
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      photo: map['photo'],
      role: map['role_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'photo': photo,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'role_id': role,
      'role': roleM?.toJson(),
    };
  }

  static UserModel empty() {
    return UserModel(
      email: '',
      photo: '',
      id: 0,
      name: '',
      phone: '',
      role: 0,
    );
  }
}
