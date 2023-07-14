import 'package:mobile_kepuharjo_new/Model/Masyarakat.dart';
import 'package:mobile_kepuharjo_new/Model/Surat.dart';

class Pengajuan {
  int? idPengajuan;
  String? uuid;
  String? nomorSurat;
  String? noPengantar;
  String? status;
  String? keterangan;
  String? keteranganDitolak;
  String? createdAt;
  String? updatedAt;
  String? filePdf;
  String? imageKk;
  String? imageBukti;
  String? info;
  int? idMasyarakat;
  int? idSurat;
  Masyarakat? masyarakat;
  Surat? surat;

  Pengajuan(
      {this.idPengajuan,
      this.uuid,
      this.nomorSurat,
      this.noPengantar,
      this.status,
      this.keterangan,
      this.keteranganDitolak,
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
    idPengajuan = json['id_pengajuan'];
    uuid = json['uuid'];
    nomorSurat = json['nomor_surat'];
    noPengantar = json['no_pengantar'];
    status = json['status'];
    keterangan = json['keterangan'];
    keteranganDitolak = json['keterangan_ditolak'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    filePdf = json['file_pdf'];
    imageKk = json['image_kk'];
    imageBukti = json['image_bukti'];
    info = json['info'];
    idMasyarakat = json['id_masyarakat'];
    idSurat = json['id_surat'];
    masyarakat = json['masyarakat'] != null
        ? Masyarakat.fromJson(json['masyarakat'])
        : null;
    surat = json['surat'] != null ? Surat.fromJson(json['surat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id_pengajuan'] = this.idPengajuan;
    data['uuid'] = this.uuid;
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
