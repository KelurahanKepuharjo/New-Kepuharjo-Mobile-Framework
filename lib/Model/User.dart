import 'package:mobile_kepuharjo_new/Model/Masyarakat.dart';

class User {
  String? id;
  String? password;
  String? noHp;
  String? role;
  String? createdAt;
  String? updatedAt;
  String? idMasyarakat;
  Masyarakat? masyarakat;

  User(
      {this.id,
      this.password,
      this.noHp,
      this.role,
      this.createdAt,
      this.updatedAt,
      this.idMasyarakat,
      this.masyarakat});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    noHp = json['no_hp'];
    role = json['role'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    idMasyarakat = json['id_masyarakat'];
    masyarakat = json['masyarakat'] != null
        ? new Masyarakat.fromJson(json['masyarakat'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    data['no_hp'] = this.noHp;
    data['role'] = this.role;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id_masyarakat'] = this.idMasyarakat;
    if (this.masyarakat != null) {
      data['masyarakat'] = this.masyarakat!.toJson();
    }
    return data;
  }
}
