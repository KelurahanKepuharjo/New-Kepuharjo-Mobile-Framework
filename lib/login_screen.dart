import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/home_rt.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rw/home_rw.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/dashboard_user.dart';
import 'package:mobile_kepuharjo_new/Resource/MyTextField.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';
import 'package:mobile_kepuharjo_new/register_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var nik = TextEditingController();
  var pw = TextEditingController();
  // String errorMsg = '';
  bool isLoading = false;
  void verifyLogin() {
    if (nik.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Silahkan isi Nomor Induk Kependudukan anda",
          backgroundColor: black.withOpacity(0.7),
          webShowClose: true,
          fontSize: 12,
          gravity: ToastGravity.SNACKBAR);
    } else if (nik.text.length < 16) {
      Fluttertoast.showToast(
          msg: "Nomor Induk Kependudukan tidak boleh kurang dari 16 digit",
          backgroundColor: black.withOpacity(0.7),
          webShowClose: true,
          fontSize: 12,
          gravity: ToastGravity.SNACKBAR);
    } else if (pw.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Silahkan isi kata sandi anda",
          backgroundColor: black.withOpacity(0.7),
          webShowClose: true,
          fontSize: 12,
          gravity: ToastGravity.SNACKBAR);
    } else if (pw.text.length < 8) {
      Fluttertoast.showToast(
          msg: "Kata sandi tidak boleh kurang dari 8 karakter",
          backgroundColor: black.withOpacity(0.7),
          webShowClose: true,
          fontSize: 12,
          gravity: ToastGravity.SNACKBAR);
    } else {
      login();
    }
  }

  Future login() async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await http.post(Uri.parse(Api.login),
          body: {"nik": nik.text, "password": pw.text});
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data['message'] == "Berhasil login") {
          setState(() {
            nik.clear();
            pw.clear();
          });
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', data['token']);
          prefs.setString('role', data['role']);
          prefs.setString('user', json.encode(data['user']));
          final role = data['role'];
          final firebaseMessaging = FirebaseMessaging.instance;
          String? fcmToken = await firebaseMessaging.getToken();
          // Send the FCM token to the server
          ApiServices apiServices = ApiServices();
          await apiServices.sendFcmToken(fcmToken!);
          await firebaseMessaging.subscribeToTopic('all');

          if (role == "4") {
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardUser(),
              ),
              (Route<dynamic> route) => false,
            );
            Fluttertoast.showToast(
                msg: "Selamat anda berhasil masuk",
                backgroundColor: black.withOpacity(0.7),
                webShowClose: true,
                fontSize: 12,
                gravity: ToastGravity.SNACKBAR);
          } else if (role == "2") {
            // Jika role == 2, push ke DashboardRt
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardRT(),
              ),
              (Route<dynamic> route) => false,
            );
            Fluttertoast.showToast(
                msg: "Selamat anda berhasil masuk",
                backgroundColor: black.withOpacity(0.7),
                webShowClose: true,
                fontSize: 12,
                gravity: ToastGravity.SNACKBAR);
          } else if (role == "3") {
            // Jika role == 3, push ke DashboardRw
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const DashboardRW(),
              ),
              (Route<dynamic> route) => false,
            );
            Fluttertoast.showToast(
                msg: "Selamat anda berhasil masuk",
                backgroundColor: black.withOpacity(0.7),
                webShowClose: true,
                fontSize: 12,
                gravity: ToastGravity.SNACKBAR);
          }
        }
      } else {
        final data = jsonDecode(res.body);
        if (data['message'] == "Nik Anda Belum Terdaftar") {
          Fluttertoast.showToast(
              msg:
                  "Silahkan Aktifkan Nomor Induk Kependudukan anda terlebih dahulu",
              backgroundColor: black.withOpacity(0.7),
              webShowClose: true,
              fontSize: 12,
              gravity: ToastGravity.SNACKBAR);
        } else if (data['message'] == "Password Anda Salah") {
          Fluttertoast.showToast(
              msg: "Password anda salah",
              backgroundColor: black.withOpacity(0.7),
              webShowClose: true,
              fontSize: 12,
              gravity: ToastGravity.SNACKBAR);
        } else {
          print("gagal masuk");
        }
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  final formKey = GlobalKey<FormState>();
  bool showpass = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/tompokersan.png",
                        height: 60,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Sistem Online Bantu Administrasi Desa",
                        textAlign: TextAlign.center,
                        style: MyFont.poppins(
                            fontSize: 12,
                            color: black,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
                  child: Row(
                    children: [
                      Text(
                        "Masuk",
                        style: MyFont.montserrat(
                            fontSize: 30,
                            color: black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const SizedBox(
                  height: 20,
                ),
                GetTextFieldUser(
                  controller: nik,
                  label: "Nomor Induk Kependudukan",
                  keyboardType: TextInputType.number,
                  inputFormatters:
                      FilteringTextInputFormatter.singleLineFormatter,
                  length: 16,
                  icon: Icons.person_rounded,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.lock_rounded,
                      size: 25,
                      color: grey,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        obscureText: showpass,
                        controller: pw,
                        style: MyFont.poppins(fontSize: 13, color: black),
                        keyboardType: TextInputType.name,
                        onSaved: (val) => pw = val as TextEditingController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Masukan password anda';
                          }
                          return null;
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.singleLineFormatter,
                          LengthLimitingTextInputFormatter(100)
                        ],
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: grey)),
                            labelText: "Kata sandi",
                            labelStyle:
                                MyFont.poppins(fontSize: 13, color: grey),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showpass = !showpass;
                                  });
                                },
                                icon: showpass
                                    ? Icon(
                                        Icons.visibility_off,
                                        size: 20,
                                        color: grey,
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: tPrimary,
                                        size: 20,
                                      ))),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: tPrimary,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onPressed: () async {
                        isLoading ? null : verifyLogin();
                      },
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: white,
                            )
                          : Text('Masuk',
                              style: MyFont.poppins(
                                  fontSize: 14,
                                  color: white,
                                  fontWeight: FontWeight.bold)),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum mengaktifkan akun ? ",
                      style: MyFont.poppins(fontSize: 11, color: grey),
                    ),
                    InkWell(
                      child: Text("Aktifasi Akun",
                          style: MyFont.poppins(
                              fontSize: 12,
                              color: tPrimary,
                              fontWeight: FontWeight.w600)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RegisterPage()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
