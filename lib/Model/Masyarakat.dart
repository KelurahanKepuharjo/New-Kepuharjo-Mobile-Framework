import 'package:mobile_kepuharjo_new/Model/Kks.dart';

class Masyarakat {
  String? idMasyarakat;
  String? nik;
  String? namaLengkap;
  String? jenisKelamin;
  String? tempatLahir;
  String? tglLahir;
  String? agama;
  String? pendidikan;
  String? pekerjaan;
  String? golonganDarah;
  String? statusPerkawinan;
  String? tglPerkawinan;
  String? statusKeluarga;
  String? kewarganegaraan;
  String? noPaspor;
  String? noKitap;
  String? namaAyah;
  String? namaIbu;
  String? createdAt;
  String? updatedAt;
  String? id;
  Kks? kks;

  Masyarakat(
      {this.idMasyarakat,
      this.nik,
      this.namaLengkap,
      this.jenisKelamin,
      this.tempatLahir,
      this.tglLahir,
      this.agama,
      this.pendidikan,
      this.pekerjaan,
      this.golonganDarah,
      this.statusPerkawinan,
      this.tglPerkawinan,
      this.statusKeluarga,
      this.kewarganegaraan,
      this.noPaspor,
      this.noKitap,
      this.namaAyah,
      this.namaIbu,
      this.createdAt,
      this.updatedAt,
      this.id,
      this.kks});

  Masyarakat.fromJson(Map<String, dynamic> json) {
    idMasyarakat = json['id_masyarakat'];
    nik = json['nik'];
    namaLengkap = json['nama_lengkap'];
    jenisKelamin = json['jenis_kelamin'];
    tempatLahir = json['tempat_lahir'];
    tglLahir = json['tgl_lahir'];
    agama = json['agama'];
    pendidikan = json['pendidikan'];
    pekerjaan = json['pekerjaan'];
    golonganDarah = json['golongan_darah'];
    statusPerkawinan = json['status_perkawinan'];
    tglPerkawinan = json['tgl_perkawinan'];
    statusKeluarga = json['status_keluarga'];
    kewarganegaraan = json['kewarganegaraan'];
    noPaspor = json['no_paspor'];
    noKitap = json['no_kitap'];
    namaAyah = json['nama_ayah'];
    namaIbu = json['nama_ibu'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    id = json['id'];
    kks = json['kks'] != null ? new Kks.fromJson(json['kks']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id_masyarakat'] = this.idMasyarakat;
    data['nik'] = this.nik;
    data['nama_lengkap'] = this.namaLengkap;
    data['jenis_kelamin'] = this.jenisKelamin;
    data['tempat_lahir'] = this.tempatLahir;
    data['tgl_lahir'] = this.tglLahir;
    data['agama'] = this.agama;
    data['pendidikan'] = this.pendidikan;
    data['pekerjaan'] = this.pekerjaan;
    data['golongan_darah'] = this.golonganDarah;
    data['status_perkawinan'] = this.statusPerkawinan;
    data['tgl_perkawinan'] = this.tglPerkawinan;
    data['status_keluarga'] = this.statusKeluarga;
    data['kewarganegaraan'] = this.kewarganegaraan;
    data['no_paspor'] = this.noPaspor;
    data['no_kitap'] = this.noKitap;
    data['nama_ayah'] = this.namaAyah;
    data['nama_ibu'] = this.namaIbu;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['id'] = this.id;
    if (this.kks != null) {
      data['kks'] = this.kks!.toJson();
    }
    return data;
  }
}
