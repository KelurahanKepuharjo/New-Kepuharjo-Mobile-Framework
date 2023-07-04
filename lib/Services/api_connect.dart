class Api {
  static const connectapi = "http://192.168.0.117:8000";
  static const connectHost = "$connectapi/api";
  static const connectimage = "$connectapi/images/";
  static const connectpdf = "$connectapi/pdf/";

  //auth
  static const login = "$connectHost/auth/login";
  static const register = "$connectHost/auth/register";
  static const logout = "$connectHost/auth/logout";
  static const me = "$connectHost/auth/me";
  static const fcm_token = "$connectHost/auth/fcm-token";
  static const notifikasi = "$connectHost/store";

  static const berita = "$connectHost/berita";
  static const surat = "$connectHost/surat";

  static const keluarga = "$connectHost/keluarga";

  static const pengajuan = "$connectHost/pengajuan";

  //status
  static const status = "$connectHost/status-surat";
  static const diproses = "$connectHost/status-proses";
  static const pembatalan = "$connectHost/pembatalan";

  //editnohp
  static const editnohp = "$connectHost/editnohp";

  //rt
  static const status_surat_rt = "$connectHost/status-surat-rt";
  static const status_setuju_rt = "$connectHost/update-status-setuju-rt";
  static const status_tolak_rt = "$connectHost/update-status-tolak-rt";
  static const rekap_rt = "$connectHost/rekap-rt";

  //rw
  static const status_surat_rw = "$connectHost/status-surat-rw";
  static const rekap_rw = "$connectHost/rekap-rw";
  static const status_setuju_rw = "$connectHost/update-status-setuju-rw";
}
