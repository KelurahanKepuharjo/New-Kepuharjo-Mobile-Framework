import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/dashboard_user.dart';
import 'package:mobile_kepuharjo_new/Model/User.dart';
import 'package:mobile_kepuharjo_new/Services/api_services.dart';
import 'package:mobile_kepuharjo_new/Services/auth_services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:intl/date_symbol_data_local.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:mobile_kepuharjo_new/Model/Keluarga.dart';
import 'package:mobile_kepuharjo_new/Model/Masyarakat.dart';
import 'package:mobile_kepuharjo_new/Resource/MyTextField_Pengajuan.dart';
import 'package:mobile_kepuharjo_new/Resource/Mycolor.dart';
import 'package:mobile_kepuharjo_new/Resource/Myfont.dart';
import 'package:mobile_kepuharjo_new/Services/api_connect.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class Pengajuansurat extends StatefulWidget {
  String idsurat;
  String namaSurat;
  Keluarga keluarga;
  Masyarakat masyarakat;
  Pengajuansurat(
      {Key? key,
      required this.idsurat,
      required this.namaSurat,
      required this.keluarga,
      required this.masyarakat})
      : super(key: key);

  @override
  State<Pengajuansurat> createState() => _PengajuansuratState();
}

class _PengajuansuratState extends State<Pengajuansurat> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    nokk.text = widget.keluarga.noKk.toString();
    nik.text = widget.masyarakat.nik.toString();
    nama.text = widget.masyarakat.namaLengkap.toString();
    String date = widget.masyarakat.tglLahir.toString();
    final dateParse = DateTime.parse(date);
    initializeDateFormatting('id_ID', null);
    final dateFormat = DateFormat('dd MMMM yyyy', 'id_ID');
    final formattedDate = dateFormat.format(dateParse);
    ttl.text = "${widget.masyarakat.tempatLahir}, $formattedDate";
    goldarah.text = widget.masyarakat.golonganDarah.toString();
    jk.text = widget.masyarakat.jenisKelamin.toString();
    kewarganegaraan.text = widget.masyarakat.kewarganegaraan.toString();
    agama.text = widget.masyarakat.agama.toString();
    statusperkawinan.text = widget.masyarakat.statusPerkawinan.toString();
    pekerjaan.text = widget.masyarakat.pekerjaan.toString();
    pendidikan.text = widget.masyarakat.pendidikan.toString();
    alamat.text = widget.keluarga.alamat.toString();
    rt.text = widget.keluarga.rt.toString();
    rw.text = widget.keluarga.rw.toString();
  }

  final nokk = TextEditingController();
  final nik = TextEditingController();
  final nama = TextEditingController();
  final ttl = TextEditingController();
  final goldarah = TextEditingController();
  final jk = TextEditingController();
  final kewarganegaraan = TextEditingController();
  final agama = TextEditingController();
  final statusperkawinan = TextEditingController();
  final pekerjaan = TextEditingController();
  final pendidikan = TextEditingController();
  final alamat = TextEditingController();
  final rt = TextEditingController();
  final rw = TextEditingController();
  final keperluan = TextEditingController();

  void verifypengajuan() {
    if (keperluan.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Silahkan isi keperluan anda",
          backgroundColor: black.withOpacity(0.7));
    } else if (imageKK == null) {
      Fluttertoast.showToast(
          msg: "Silahkan upload foto Kartu Keluarga anda",
          backgroundColor: black.withOpacity(0.7));
    } else if (imageBukti == null) {
      Fluttertoast.showToast(
          msg: "Silahkan upload foto bukti/pendukung anda",
          backgroundColor: black.withOpacity(0.7));
    } else {
      showSuccessDialog(context);
    }
  }

  ApiServices apiServices = ApiServices();

  // Future submitForm() async {
  //   if (imageKK == null || imageBukti == null) {
  //     Fluttertoast.showToast(
  //         msg: "Silahkan upload foto bukti dan Kartu Keluarga anda",
  //         backgroundColor: black.withOpacity(0.7));
  //   }
  //   const url = Api.pengajuan;
  //
  //   final dio = Dio();
  //   var cookieJar = CookieJar();
  //
  //   dio.interceptors.add(CookieManager(cookieJar));
  //   final formData = FormData.fromMap({
  //     'keterangan': keperluan.text,
  //     'id_surat': widget.idsurat,
  //     'nik': widget.masyarakat.nik.toString(),
  //     'image_kk': await MultipartFile.fromFile(
  //       imageKK!.path,
  //       filename: 'image_kk.jpg',
  //     ),
  //     'image_bukti': await MultipartFile.fromFile(
  //       imageBukti!.path,
  //       filename: 'image_bukti.jpg',
  //     ),
  //   });
  //   // Hindari validasi 5xx status
  //   try {
  //     final response = await dio.post(url,
  //         data: formData,
  //         options: Options(
  //           followRedirects: false,
  //           validateStatus: (status) {
  //             return status! < 500;
  //           },
  //           contentType: 'application/json',
  //           responseType: ResponseType.plain,
  //         ));
  //
  //     if (response.statusCode == 200) {
  //       print('Pengajuan surat berhasil');
  //     } else {
  //       print('Gagal mengajukan surat. Status: ${response.statusCode}');
  //     }
  //   } on DioError catch (e) {
  //     if (e.response != null) {
  //       final responseData = e.response!.data;
  //       print('Gagal mengajukan surat. Respons dari server: $responseData');
  //     } else {
  //       print('Gagal mengajukan surat. Kesalahan lainnya: $e');
  //     }
  //   }
  // }

  showSuccessDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.SUCCES,
      title: 'Warning!',
      titleTextStyle: MyFont.poppins(
          fontSize: 25, color: lavender, fontWeight: FontWeight.bold),
      desc: 'Apakah anda yakin, Jika data yang anda telah benar',
      descTextStyle: MyFont.poppins(fontSize: 12, color: softgrey),
      btnOkOnPress: () {
        // submitForm();
      },
      btnCancelOnPress: () {
        Navigator.pop(context);
      },
      btnCancelIcon: Icons.highlight_off_rounded,
      btnOkIcon: Icons.task_alt_rounded,
    ).show();
  }

  Future getImageGalerryKK() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageKK = File(imageFile!.path);
    });
  }

  Future getImageGalerryBukti() async {
    final picker = ImagePicker();
    final imageFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageBukti = File(imageFile!.path);
    });
  }

  User? user;

  Future<void> getUser() async {
    final authServices = AuthServices();
    final auth = await authServices.me();
    if (auth != null) {
      setState(() {
        user = auth;
      });
    }
  }

  File? imageKK;
  File? imageBukti;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
          backgroundColor: white,
          shadowColor: Colors.transparent,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text(
            "Pengajuan Surat",
            style: MyFont.poppins(
                fontSize: 14, color: black, fontWeight: FontWeight.bold),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.keyboard_arrow_left_rounded,
                color: black,
              ),
            ),
          )),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
              child: Text(
                "Pengajuan Surat Keterangan ${widget.namaSurat}",
                style: MyFont.poppins(
                    fontSize: 13, color: black, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 20),
              child: Text(
                "Silahkan pastikan bahwa semua data anda sudah terisi semua",
                style: MyFont.poppins(
                    fontSize: 11, color: black, fontWeight: FontWeight.normal),
              ),
            ),
            GetTextFieldPengajuan(
                controller: nokk,
                label: "No. Kartu Keluarga",
                keyboardType: TextInputType.name,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter),
            GetTextFieldPengajuan(
              controller: nik,
              label: "No. Induk Keluarga",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: nama,
              label: "Nama Lengkap",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: ttl,
              label: "Tempat, Tanggal Lahir",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: goldarah,
              label: "Golongan Darah",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: jk,
              label: "Jenis Kelamin",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: kewarganegaraan,
              label: "Kewarganegaraan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: agama,
              label: "Agama",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: statusperkawinan,
              label: "Status Perkawinan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: pekerjaan,
              label: "Pekerjaan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: pendidikan,
              label: "Pendidikan",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: alamat,
              label: "Alamat",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: rt,
              label: "RT",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: rw,
              label: "RW",
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            GetTextFieldPengajuan(
              controller: keperluan,
              label: "Keperluan",
              isEnable: true,
              keyboardType: TextInputType.name,
              inputFormatters: FilteringTextInputFormatter.singleLineFormatter,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                getImageGalerryKK();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(10),
                    dashPattern: [8, 4],
                    strokeCap: StrokeCap.round,
                    color: black,
                    child: imageKK == null
                        ? Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "images/photo.png",
                                  height: 40,
                                  color: black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Upload Foto Kartu Keluarga",
                                  style: MyFont.poppins(
                                      fontSize: 12, color: softgrey),
                                )
                              ],
                            ),
                          )
                        : Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: FileImage(imageKK!),
                                    fit: BoxFit.cover)),
                          )),
              ),
            ),
            GestureDetector(
              onTap: () {
                getImageGalerryBukti();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                child: DottedBorder(
                    borderType: BorderType.RRect,
                    radius: Radius.circular(10),
                    dashPattern: [8, 4],
                    strokeCap: StrokeCap.round,
                    color: black,
                    child: imageBukti == null
                        ? Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "images/photo.png",
                                  height: 40,
                                  color: black,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Upload Foto Bukti",
                                  style: MyFont.poppins(
                                      fontSize: 12, color: softgrey),
                                )
                              ],
                            ),
                          )
                        : Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: FileImage(imageBukti!),
                                    fit: BoxFit.cover)),
                          )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: SizedBox(
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
                      if (keperluan.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Silahkan isi keperluan anda",
                            backgroundColor: black.withOpacity(0.7));
                      } else {
                        final request = http.MultipartRequest(
                            'POST', Uri.parse(Api.pengajuan));
                        request.fields['keterangan'] = keperluan.text;
                        request.fields['id_surat'] = widget.idsurat;
                        request.fields['nik'] =
                            widget.masyarakat.nik.toString();

                        // Tambahkan gambar KK (jika sudah dipilih)
                        if (imageKK != null) {
                          final kkFile = await http.MultipartFile.fromPath(
                            'image_kk',
                            imageKK!.path,
                            contentType: MediaType(
                                'image', path.extension(imageKK!.path)),
                          );
                          request.files.add(kkFile);
                        }

                        // Tambahkan gambar bukti (jika sudah dipilih)
                        if (imageBukti != null) {
                          final buktiFile = await http.MultipartFile.fromPath(
                            'image_bukti',
                            imageBukti!.path,
                            contentType: MediaType(
                                'image', path.extension(imageBukti!.path)),
                          );
                          request.files.add(buktiFile);
                        }

                        try {
                          // Kirim permintaan ke backend
                          final response = await request.send();

                          if (response.statusCode == 200) {
                            final responseString =
                                await response.stream.bytesToString();

                            // Parse responseString sebagai JSON
                            final jsonResponse = json.decode(responseString);

                            // Cek apakah ada pesan dari server
                            if (jsonResponse.containsKey('message')) {
                              final message = jsonResponse['message'];

                              // Cek apakah pesan adalah "Surat sebelumnya belum selesai"
                              if (message == 'Surat sebelumnya belum selesai') {
                                Fluttertoast.showToast(
                                  msg: message,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.7),
                                );
                              } else if (message ==
                                  'Berhasil mengajukan surat') {
                                apiServices.sendNotificationRt();
                                Fluttertoast.showToast(
                                  msg: message,
                                  backgroundColor:
                                      Colors.black.withOpacity(0.7),
                                ).then((value) => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DashboardUser(),
                                    )));
                                // ignore: use_build_context_synchronously
                              }
                            } else {
                              print('Pengajuan surat berhasil');
                            }
                          } else {
                            // Jika gagal, tangkap pesan kesalahan dari respons
                            final responseString =
                                await response.stream.bytesToString();
                            print(
                                'Pengajuan surat gagal. Respons dari server: $responseString');
                          }
                        } catch (e) {
                          // Tangkap kesalahan jika terjadi kesalahan selain dari respons server
                          print('Pengajuan surat gagal. Kesalahan lainnya: $e');
                        }
                      }
                    },
                    child: Text('Ajukan Surat',
                        textAlign: TextAlign.center,
                        style: MyFont.poppins(
                            fontSize: 14,
                            color: white,
                            fontWeight: FontWeight.bold)),
                  )),
            ),
          ],
        ),
      ),
    );
  }

// ... kode lainnya ...

// Fungsi untuk mengunggah data dan gambar ke backend (menggunakan paket http)
  Future<void> uploadDataAndImages() async {
    const url = Api.pengajuan; // Ganti URL sesuai dengan endpoint backend Anda

    final request = http.MultipartRequest('POST', Uri.parse(url));
    // Tambahkan bearer token ke header permintaan
    final prefs = await SharedPreferences.getInstance();
    final bearerToken = prefs.getString('token'); // Ganti dengan token Anda
    request.headers['Authorization'] = 'Bearer $bearerToken';

    // Tambahkan data pengajuan dari controller yang sudah diisi sebelumnya
    // Contoh:
    request.fields['keterangan'] = keperluan.text;
    request.fields['id_surat'] = widget.idsurat;
    request.fields['nik'] = widget.masyarakat.nik.toString();

    // Tambahkan gambar KK (jika sudah dipilih)
    if (imageKK != null) {
      final kkFile = await http.MultipartFile.fromPath(
        'image_kk',
        imageKK!.path,
        contentType: MediaType('image', path.extension(imageKK!.path)),
      );
      request.files.add(kkFile);
    }

    // Tambahkan gambar bukti (jika sudah dipilih)
    if (imageBukti != null) {
      final buktiFile = await http.MultipartFile.fromPath(
        'image_bukti',
        imageBukti!.path,
        contentType: MediaType('image', path.extension(imageBukti!.path)),
      );
      request.files.add(buktiFile);
    }

    try {
      // Kirim permintaan ke backend
      final response = await request.send();

      if (response.statusCode == 200) {
        // Jika berhasil, lakukan sesuatu (misalnya menampilkan pesan berhasil)
        print('Pengajuan surat berhasil');
      } else {
        // Jika gagal, tangkap pesan kesalahan dari respons
        final responseString = await response.stream.bytesToString();
        print('Pengajuan surat gagal. Respons dari server: $responseString');
      }
    } catch (e) {
      // Tangkap kesalahan jika terjadi kesalahan selain dari respons server
      print('Pengajuan surat gagal. Kesalahan lainnya: $e');
    }
  }
}
