import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_kepuharjo_new/Resource/MyTextField.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:mobile_kepuharjo_new/login_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var nik = TextEditingController();
  var pw = TextEditingController();
  var notlp = TextEditingController();
  var conpw = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showpass = true;
  bool showconp = true;
  bool isLoading = false;
  String errorMsg = '';
  void verifyRegister() {
    setState(() {
      errorMsg = '';
    });
    if (nik.text.isEmpty) {
      setState(() {
        errorMsg = "Silahkan isi Nomor Induk Kependudukan anda";
      });
    } else if (nik.text.length < 16) {
      setState(() {
        errorMsg = "Nik tidak boleh kurang dari 16 digit";
      });
    } else if (pw.text.isEmpty) {
      setState(() {
        errorMsg = "Silahkan isi kata sandi anda";
      });
    } else if (pw.text.length < 8) {
      setState(() {
        errorMsg = "Kata sandi tidak boleh kurang dari 8 karakter";
      });
    } else if (pw.text.contains(RegExp(r'[A-Z]')) == false) {
      setState(() {
        errorMsg = "Kata sandi harus mengandung kuruf kapital";
      });
    } else if (pw.text.contains(RegExp(r'[a-z]')) == false) {
      setState(() {
        errorMsg = "Kata sandi harus mengandung kuruf kecil";
      });
    } else if (pw.text.contains(RegExp(r'\d')) == false) {
      setState(() {
        errorMsg = "Kata sandi harus mengandung angka";
      });
    } else if (pw.text.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]')) == false) {
      setState(() {
        errorMsg = "Kata sandi harus mengandung spesial karakter";
      });
    } else if (conpw.text.contains(RegExp(r'[A-Z]')) == false) {
      setState(() {
        errorMsg = "Konfirmasi Kata sandi harus mengandung kuruf kapital";
      });
    } else if (conpw.text.contains(RegExp(r'[a-z]')) == false) {
      setState(() {
        errorMsg = "Konfirmasi Kata sandi harus mengandung kuruf kecil";
      });
    } else if (conpw.text.contains(RegExp(r'\d')) == false) {
      setState(() {
        errorMsg = "Konfirmasi Kata sandi harus mengandung angka";
      });
    } else if (conpw.text.contains(RegExp(r'[!@#\$%^&*(),.?":{}|<>]')) ==
        false) {
      setState(() {
        errorMsg = "Konfirmasi Kata sandi harus mengandung spesial karakter";
      });
    } else if (conpw.text.isEmpty) {
      setState(() {
        errorMsg = "Silahkan isi konfirmasi kata sandi anda";
      });
    } else if (conpw.text.length < 8) {
      setState(() {
        errorMsg = "Kata sandi tidak boleh kurang dari 8 karakter";
      });
    } else if (pw.text != conpw.text) {
      setState(() {
        errorMsg = "Kata sandi harus sama";
      });
    } else if (notlp.text.isEmpty) {
      setState(() {
        errorMsg = "Silahkan isi no.telepon anda";
      });
    } else if (notlp.text.length < 11) {
      setState(() {
        errorMsg = "No.Telepon tidak boleh kurang dari 11 digit";
      });
    } else {
      register();
    }
  }

  Future register() async {
    setState(() {
      isLoading = true;
      errorMsg = '';
    });
    try {
      var res = await http.post(Uri.parse(Api.register), body: {
        "nik": nik.text,
        "no_hp": notlp.text,
        "password": pw.text,
      });
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data["message"] == "Berhasil Register") {
          Fluttertoast.showToast(
              msg: "Nik anda berhasil diaktifkan",
              backgroundColor: Colors.green);
          setState(() {
            nik.clear();
            notlp.clear();
            pw.clear();
          });
          
        }
      } else {
        final data = jsonDecode(res.body);
        if (data["message"] == "Akun sudah terdaftar") {
          setState(() {
            errorMsg = "NIK sudah terdaftar";
          });
        } else if (data["message"] == "Nik anda belum terdaftar") {
          setState(() {
            errorMsg = "Silahkan melakukan aktifasi akun anda terlebih dahulu";
          });
        } else {
          setState(() {
            errorMsg = "Gagal Daftar";
          });
        }
      }
    } catch (e) {
      errorMsg = e.toString();
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          // physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(" S-Kepuharjo",
                            style: MyFont.montserrat(
                                fontSize: 24,
                                color: black,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          width: 5,
                        ),
                        Image.asset(
                          "images/mylogo.png",
                          height: 45,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Smart aplikasi layanan pengajuan\nsurat keterangan.",
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
                      "Aktifasi Akun",
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
              GetTextFieldUser(
                controller: nik,
                label: "No. NIK",
                keyboardType: TextInputType.number,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
                length: 16,
                icon: Icons.person_rounded,
              ),
              const SizedBox(
                height: 20,
              ),
              GetTextFieldUser(
                controller: notlp,
                label: "No.Telepon",
                keyboardType: TextInputType.number,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
                length: 16,
                icon: Icons.call,
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
                        LengthLimitingTextInputFormatter(20)
                      ],
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: grey)),
                          labelText: "Password",
                          labelStyle: MyFont.poppins(fontSize: 13, color: grey),
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
                                      color: primaryColor,
                                      size: 20,
                                    ))),
                    ),
                  ),
                ],
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
                      obscureText: showconp,
                      controller: conpw,
                      style: MyFont.poppins(fontSize: 13, color: black),
                      keyboardType: TextInputType.name,
                      onSaved: (val) => conpw = val as TextEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukan konfirmasi password anda';
                        }
                        return null;
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter,
                        LengthLimitingTextInputFormatter(20)
                      ],
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: grey)),
                          labelText: "Konfirmasi Password",
                          labelStyle: MyFont.poppins(fontSize: 13, color: grey),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showconp = !showconp;
                                });
                              },
                              icon: showconp
                                  ? Icon(
                                      Icons.visibility_off,
                                      size: 20,
                                      color: grey,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: primaryColor,
                                      size: 20,
                                    ))),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              errorMsg.isEmpty
                  ? SizedBox.shrink()
                  : Text(
                      errorMsg,
                      style: MyFont.poppins(fontSize: 12, color: Colors.red),
                    ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                    onPressed: () async {
                      isLoading ? null : verifyRegister();
                    },
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: white,
                          )
                        : Text('Aktifkan akun',
                            style: MyFont.poppins(fontSize: 14, color: white)),
                  )),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Sudah mengaktifasi akun ? ",
                    style: MyFont.poppins(fontSize: 11, color: grey),
                  ),
                  InkWell(
                    child: Text("Masuk",
                        style: MyFont.poppins(
                            fontSize: 12,
                            color: primaryColor,
                            fontWeight: FontWeight.bold)),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
