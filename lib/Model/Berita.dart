class Berita {
  int? id;
  String? judul;
  String? deskripsi;
  String? image;
  String? createdAt;
  String? updatedAt;

  Berita(
      {this.id,
      this.judul,
      this.deskripsi,
      this.image,
      this.createdAt,
      this.updatedAt});

  Berita.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    judul = json['judul'];
    deskripsi = json['deskripsi'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['judul'] = this.judul;
    data['deskripsi'] = this.deskripsi;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
