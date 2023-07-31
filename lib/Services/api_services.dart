import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mobile_kepuharjo_new/Model/Berita.dart';
import 'package:mobile_kepuharjo_new/Model/Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Model/Surat.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<void> sendFcmToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final authtoken = prefs.getString('token');
    try {
      final response = await http.post(
        Uri.parse(Api.fcm_token),
        body: {'fcm_token': token},
        headers: {"Authorization": "Bearer $authtoken"},
      );

      if (response.statusCode == 200) {
        print('Token perangkat berhasil disimpan di server.');
      } else {
        print('Gagal menyimpan token perangkat di server.');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  Future<void> check() async {
    final prefs = await SharedPreferences.getInstance();
    final authtoken = prefs.getString('token');
    try {
      final response = await http.get(
        Uri.parse(Api.check),
        headers: {"Authorization": "Bearer $authtoken"},
      );

      if (response.statusCode == 200) {
        final firebaseMessaging = FirebaseMessaging.instance;
        String? fcmToken = await firebaseMessaging.getToken();
        // Send the FCM token to the server
        await sendFcmToken(fcmToken!);
        await firebaseMessaging.subscribeToTopic('all');
      } else {
        final firebaseMessaging = FirebaseMessaging.instance;
        String? fcmToken = await firebaseMessaging.getToken();
        // Send the FCM token to the server
        await sendFcmToken(fcmToken!);
        await firebaseMessaging.subscribeToTopic('all');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendNotificationRt() async {
    final prefs = await SharedPreferences.getInstance();
    final authtoken = prefs.getString('token');
    try {
      final response = await http.post(Uri.parse(Api.notifikasi_rt),
          headers: {"Authorization": "Bearer $authtoken"});
      if (response.statusCode == 200) {
        print('Berhasil mengirim notifikasi ke pihak rt');
      } else {
        print('Gagal mengirim notifikasi');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  Future<void> sendNotification(String body, String token, String title) async {
    try {
      final response = await http.post(
        Uri.parse(Api.notifikasi),
        body: {'title': title, 'body': body, 'token': token},
      );
      if (response.statusCode == 200) {
        print('Berhasil mengirim notifikasi');
      } else {
        print('Gagal mengirim notifikasi');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  Future<List<Berita>> getBerita() async {
    final response = await http.get(Uri.parse(Api.berita));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((e) => Berita.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Surat>> getSurat() async {
    final response = await http.get(Uri.parse(Api.surat));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse.map((e) => Surat.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  //pengajuan rt
  Future<List<Pengajuan>> getPengajuanRt(String status) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(Uri.parse(Api.status_surat_rt),
        body: {"status": status}, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Pengajuan.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  //rekap rt
  // Future<List<Pengajuan>> getRekapRt(int page) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final response = await http.get(Uri.parse('${Api.rekap_rt}?page=$page'),
  //       headers: {"Authorization": "Bearer $token"});
  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body)['data'];
  //     return jsonResponse.map((e) => Pengajuan.fromJson(e)).toList();
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  // }
  Future<Map<String, dynamic>> getRekapRt(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(Uri.parse('${Api.rekap_rt}?page=$page'),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Pengajuan> pengajuanList =
          (jsonData['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();

      final Map<String, dynamic> result = {
        'pengajuanList': pengajuanList,
        'lastPage': jsonData['last_page'],
      };

      return result;
    } else {
      throw Exception('Failed to load');
    }
  }
  Future<Map<String, dynamic>> getRekapRw(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(Uri.parse('${Api.rekap_rw}?page=$page'),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Pengajuan> pengajuanList =
          (jsonData['data'] as List).map((e) => Pengajuan.fromJson(e)).toList();

      final Map<String, dynamic> result = {
        'pengajuanList': pengajuanList,
        'lastPage': jsonData['last_page'],
      };

      return result;
    } else {
      throw Exception('Failed to load');
    }
  }

  //pengajuan rt
  Future<List<Pengajuan>> getPengajuanRw(String status) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.post(Uri.parse(Api.status_surat_rw),
        body: {"status": status}, headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Pengajuan.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  //rekap rt
  // Future<List<Pengajuan>> getRekapRw() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //   final response = await http.get(Uri.parse(Api.rekap_rw),
  //       headers: {"Authorization": "Bearer $token"});
  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((e) => Pengajuan.fromJson(e)).toList();
  //   } else {
  //     throw Exception('Failed to load');
  //   }
  // }

  Future<List<dynamic>> keluarga() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(Uri.parse(Api.keluarga),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body)['data'];
      return jsonData;
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Pengajuan>> getStatus(String status) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var res = await http.post(Uri.parse(Api.status),
        body: {"status": status}, headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      List jsonResponse = json.decode(res.body)['data'];
      return jsonResponse.map((e) => Pengajuan.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<List<Pengajuan>> getStatusDiproses() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var res = await http.get(Uri.parse(Api.diproses),
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      List jsonResponse = json.decode(res.body)['data'];
      return jsonResponse.map((e) => Pengajuan.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }
}
