class Api {
  static const connectapi = "http://192.168.43.199:8000";
  static const connectHost = "$connectapi/api";
  static const connectimage = "$connectapi/images/";

  //auth
  static const login = "$connectHost/auth/login";
  static const register = "$connectHost/auth/register";
  static const logout = "$connectHost/auth/logout";
  static const me = "$connectHost/auth/me";

  static const berita = "$connectHost/berita";
  static const surat = "$connectHost/surat";

  static const suratmasuk = "$connectHost/suratmasuk";
  static const rekap = "$connectHost/rekap";
  static const keluarga = "$connectHost/keluarga";
  static const disetujui = "$connectHost/disetujui";
  static const pengajuan = "$connectHost/pengajuan";

  //status
  static const status = "$connectHost/statusdiajukan";
  static const diproses = "$connectHost/statusproses";
  static const pembatalan = "$connectHost/pembatalan";

  //editnohp
  static const editnohp = "$connectHost/editnohp";

  //rt
  static const status_surat_rt = "$connectHost/status-surat-rt";
  static const rekap_rt = "$connectHost/rekap-rt";

  //rw
  static const status_surat_rw = "$connectHost/status-surat-rw";
  static const rekap_rw = "$connectHost/rekap-rw";
}
