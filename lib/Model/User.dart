import 'package:mobile_kepuharjo_new/Model/Masyarakat.dart';

class User {
  int? akunId;
  String? uuid;
  String? password;
  String? noHp;
  String? role;
  String? fcmToken;
  String? createdAt;
  String? updatedAt;
  int? idMasyarakat;
  Masyarakat? masyarakat;

  User(
      {this.akunId,
      this.uuid,
      this.password,
      this.noHp,
      this.role,
      this.fcmToken,
      this.createdAt,
      this.updatedAt,
      this.idMasyarakat,
      this.masyarakat});

  User.fromJson(Map<String, dynamic> json) {
    akunId = json['akun_id'];
    uuid = json['uuid'];
    password = json['password'];
    noHp = json['no_hp'];
    role = json['role'];
    fcmToken = json['fcm_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    idMasyarakat = json['id_masyarakat'];
    masyarakat = json['masyarakat'] != null
        ? Masyarakat.fromJson(json['masyarakat'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['akun_id'] = this.akunId;
    data['uuid'] = this.uuid;
    data['password'] = this.password;
    data['no_hp'] = this.noHp;
    data['role'] = this.role;
    data['fcm_token'] = this.fcmToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id_masyarakat'] = this.idMasyarakat;
    if (this.masyarakat != null) {
      data['masyarakat'] = this.masyarakat!.toJson();
    }
    return data;
  }
}
