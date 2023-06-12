import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Model/Berita.dart';
import 'package:mobile_kepuharjo_new/Model/Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Model/Surat.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApiServices {
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
  Future<List<Pengajuan>> getRekapRt() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(Uri.parse(Api.rekap_rt),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Pengajuan.fromJson(e)).toList();
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
  Future<List<Pengajuan>> getRekapRw() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    final response = await http.get(Uri.parse(Api.rekap_rw),
        headers: {"Authorization": "Bearer $token"});
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((e) => Pengajuan.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load');
    }
  }

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
