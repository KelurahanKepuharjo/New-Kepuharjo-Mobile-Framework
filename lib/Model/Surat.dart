class Surat {
  int? idSurat;
  String? namaSurat;
  String? image;

  Surat({this.idSurat, this.namaSurat, this.image});

  Surat.fromJson(Map<String, dynamic> json) {
    idSurat = json['id_surat'];
    image = json['image'];
    namaSurat = json['nama_surat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id_surat'] = this.idSurat;
    data['image'] = this.image;
    data['nama_surat'] = this.namaSurat;
    return data;
  }
}
