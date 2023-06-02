import 'package:mobile_kepuharjo_new/Model/Masyarakat.dart';
import 'package:mobile_kepuharjo_new/Model/Surat.dart';

class Pengajuan {
  String? id;
  String? nomorSurat;
  String? status;
  String? keterangan;
  String? createdAt;
  String? updatedAt;
  String? filePdf;
  String? imageKk;
  String? imageBukti;
  String? info;
  String? idMasyarakat;
  String? idSurat;
  Masyarakat? masyarakat;
  Surat? surat;

  Pengajuan(
      {this.id,
      this.nomorSurat,
      this.status,
      this.keterangan,
      this.createdAt,
      this.updatedAt,
      this.filePdf,
      this.imageKk,
      this.imageBukti,
      this.info,
      this.idMasyarakat,
      this.idSurat,
      this.masyarakat,
      this.surat});

  Pengajuan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomorSurat = json['nomor_surat'];
    status = json['status'];
    keterangan = json['keterangan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    filePdf = json['file_pdf'];
    imageKk = json['image_kk'];
    imageBukti = json['image_bukti'];
    info = json['info'];
    idMasyarakat = json['id_masyarakat'];
    idSurat = json['id_surat'];
    masyarakat = json['masyarakat'] != null
        ? new Masyarakat.fromJson(json['masyarakat'])
        : null;
    surat = json['surat'] != null ? new Surat.fromJson(json['surat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nomor_surat'] = this.nomorSurat;
    data['status'] = this.status;
    data['keterangan'] = this.keterangan;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['file_pdf'] = this.filePdf;
    data['image_kk'] = this.imageKk;
    data['image_bukti'] = this.imageBukti;
    data['info'] = this.info;
    data['id_masyarakat'] = this.idMasyarakat;
    data['id_surat'] = this.idSurat;
    if (this.masyarakat != null) {
      data['masyarakat'] = this.masyarakat!.toJson();
    }
    if (this.surat != null) {
      data['surat'] = this.surat!.toJson();
    }
    return data;
  }
}
