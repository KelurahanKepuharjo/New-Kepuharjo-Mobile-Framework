class Api {
  static const connectapi = "https://suketkepuharjo.com";
  static const connectHost = "$connectapi/api";
  static const connectimage = "$connectapi/images/";
  static const connectpdf = "$connectapi/pdf/";

  //auth
  static const login = "$connectHost/auth/login";
  static const register = "$connectHost/auth/register";
  static const logout = "$connectHost/auth/logout";
  static const me = "$connectHost/auth/me";
  static const fcm_token = "$connectHost/auth/fcm-token";
  static const check = "$connectHost/auth/fcm-token-check";
  static const checkRole = "$connectHost/auth/role";
  static const notifikasi = "$connectHost/store";
  static const notifikasi_rt = "$connectHost/send-notification-rt";
  static const notifikasi_user = "$connectHost/send-notification-user";
  static const notifikasi_rw = "$connectHost/send-notification-rw";

  static const berita = "$connectHost/berita";
  static const news = "$connectHost/news";
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
