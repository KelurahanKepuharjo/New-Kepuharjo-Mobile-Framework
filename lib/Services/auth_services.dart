import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/custom_navigation_drawer.dart';
import 'package:mobile_kepuharjo_new/Model/Keluarga.dart';
import 'package:mobile_kepuharjo_new/Model/User.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:mobile_kepuharjo_new/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  Future logout(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var res = await http.post(Uri.parse(Api.logout),
          headers: {"Authorization": "Bearer $token"});
      if (res.statusCode == 200) {
        prefs.remove('token');
        prefs.remove('user');
        prefs.remove('role');
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
        ).then((value) => Fluttertoast.showToast(
            msg: "Berhasil keluar dari aplikasi",
            backgroundColor: black.withOpacity(0.7)));
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<User?> me() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var res = await http
          .get(Uri.parse(Api.me), headers: {"Authorization": "Bearer $token"});
      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body)['data'];
        final user = User.fromJson(jsonData);
        prefs.setString('data', json.encode(jsonData));
        return user;
      } else {
        throw Exception("Failed to fetch user data");
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List<Keluarga>> getMasyarakat() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    var res = await http.get(Uri.parse(Api.keluarga),
        headers: {"Authorization": "Bearer $token"});
    if (res.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(res.body)['data'];
      List<dynamic> masyarakat = jsonResponse['masyarakat'];
      return masyarakat.map((e) => Keluarga.fromJson(jsonResponse)).toList();
    } else {
      throw Exception("Failed to get keluarga data");
    }
  }
}
