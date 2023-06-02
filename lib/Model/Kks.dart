class Kks {
  String? id;
  String? noKk;
  String? alamat;
  String? rt;
  String? rw;
  String? kodePos;
  String? kelurahan;
  String? kecamatan;
  String? kabupaten;
  String? provinsi;
  String? kkTgl;
  String? createdAt;
  String? updatedAt;

  Kks(
      {this.id,
      this.noKk,
      this.alamat,
      this.rt,
      this.rw,
      this.kodePos,
      this.kelurahan,
      this.kecamatan,
      this.kabupaten,
      this.provinsi,
      this.kkTgl,
      this.createdAt,
      this.updatedAt});

  Kks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noKk = json['no_kk'];
    alamat = json['alamat'];
    rt = json['rt'];
    rw = json['rw'];
    kodePos = json['kode_pos'];
    kelurahan = json['kelurahan'];
    kecamatan = json['kecamatan'];
    kabupaten = json['kabupaten'];
    provinsi = json['provinsi'];
    kkTgl = json['kk_tgl'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['no_kk'] = this.noKk;
    data['alamat'] = this.alamat;
    data['rt'] = this.rt;
    data['rw'] = this.rw;
    data['kode_pos'] = this.kodePos;
    data['kelurahan'] = this.kelurahan;
    data['kecamatan'] = this.kecamatan;
    data['kabupaten'] = this.kabupaten;
    data['provinsi'] = this.provinsi;
    data['kk_tgl'] = this.kkTgl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
