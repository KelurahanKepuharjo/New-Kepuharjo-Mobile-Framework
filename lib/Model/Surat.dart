class Surat {
  String? idSurat;
  String? uuid;
  String? image;
  String? namaSurat;

  Surat({this.idSurat, this.uuid, this.namaSurat});

  Surat.fromJson(Map<String, dynamic> json) {
    idSurat = json['id_surat'];
    uuid = json['uuid'];
    image = json['image'];
    namaSurat = json['nama_surat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id_surat'] = this.idSurat;
    data['uuid'] = this.uuid;
    data['image'] = this.image;
    data['nama_surat'] = this.namaSurat;
    return data;
  }
}
