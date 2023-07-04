import 'dart:async';

import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/custom_navigation_drawer.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_berita.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_pelayanan.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/Screen/Home/widget_text_berita.dart';
import 'package:mobile_kepuharjo_new/Model/User.dart';
import 'package:mobile_kepuharjo_new/Resource/MySnackbar.dart';
import 'package:mobile_kepuharjo_new/Resource/MySnackbar.dart';
import 'package:mobile_kepuharjo_new/Services/auth_services.dart';

class HomeUser extends StatefulWidget {
  const HomeUser({super.key});

  @override
  State<HomeUser> createState() => _HomeUserState();
}

class _HomeUserState extends State<HomeUser> {
  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        select = !select;
      });
    });
    getUser();
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _timer?.cancel();
  }

  bool select = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            title: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text(
                    "S-Kepuharjo",
                    style: MyFont.montserrat(
                        fontSize: 18,
                        color: white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    "images/mylogo.png",
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
            ),
            pinned: true,
            backgroundColor: primaryColor,
            shadowColor: Colors.transparent,
            expandedHeight: 200,
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(10),
                child: Container(
                  height: 15,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                )),
            flexibleSpace: FlexibleSpaceBar(
                background: Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
              color: blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: Card(
                      elevation: 1, // tinggi bayangan
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 0, 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Selamat Datang, ",
                                  style: MyFont.poppins(
                                      fontSize: 12,
                                      color: black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Image.asset(
                                  "images/hand.png",
                                  height: 20,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.grey.shade700,
                                  ),
                                  child: Center(
                                    child: Image.asset(
                                      "images/account.png",
                                      color: white,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Visibility(
                                        visible: user != null &&
                                            user!.masyarakat != null,
                                        replacement: CardLoading(
                                          height: 15,
                                          width: 150,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // color: Colors.grey,
                                        ),
                                        child: Text(
                                          user?.masyarakat?.namaLengkap ?? "",
                                          style: MyFont.poppins(
                                            fontSize: 12,
                                            color: black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: user != null &&
                                            user!.masyarakat != null,
                                        replacement: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: CardLoading(
                                            height: 15,
                                            width: 200,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            // color: Colors.grey,
                                          ),
                                        ),
                                        child: Text(
                                          user?.masyarakat?.nik.toString() ??
                                              "",
                                          style: MyFont.poppins(
                                            fontSize: 11,
                                            color: black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
                // Stack(
                //   fit: StackFit.expand,
                //   children: [
                //     ColorFiltered(
                //       colorFilter: ColorFilter.mode(
                //           Colors.black.withOpacity(0.4), BlendMode.darken),
                //       child: Image.asset(w
                //         "images/kab.jpeg",
                //         fit: BoxFit.cover,
                //         width: double.maxFinite,
                //       ),
                //     ),
                //     Positioned(
                //       top: 70,
                //       child: AnimatedContainer(
                //         alignment: Alignment.centerLeft,
                //         duration: Duration(seconds: 1),
                //         color: Colors.transparent,
                //         padding: EdgeInsets.fromLTRB(25, 25, 25, 15),
                //         width: MediaQuery.of(context).size.width,
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             select
                //                 ? AnimatedDefaultTextStyle(
                //                     style:
                //                         MyFont.inter(fontSize: 18, color: white),
                //                     duration: Duration(seconds: 2),
                //                     child: Text(""))
                //                 : Padding(
                //                     padding:
                //                         const EdgeInsets.only(top: 10, left: 8),
                //                     child: AnimatedDefaultTextStyle(
                //                         curve: Curves.slowMiddle,
                //                         style: MyFont.poppins(
                //                             fontSize: 18,
                //                             color: white,
                //                             fontWeight: FontWeight.bold),
                //                         duration: Duration(seconds: 2),
                //                         child: Text(
                //                           "Profil Kelurahan",
                //                           style: MyFont.poppins(
                //                               fontSize: 18,
                //                               color: white,
                //                               fontWeight: FontWeight.bold),
                //                         )),
                //                   ),
                //             select
                //                 ? AnimatedDefaultTextStyle(
                //                     style:
                //                         MyFont.inter(fontSize: 18, color: white),
                //                     duration: Duration(seconds: 2),
                //                     child: Text(""))
                //                 : Padding(
                //                     padding: const EdgeInsets.only(
                //                         left: 8.0, bottom: 10),
                //                     child: AnimatedDefaultTextStyle(
                //                       curve: Curves.slowMiddle,
                //                       style: MyFont.poppins(
                //                         fontSize: 11,
                //                         color: white,
                //                       ),
                //                       duration: Duration(seconds: 2),
                //                       child: Text(
                //                         "Kel. Kepuharjo, Kec. Lumajang, Kab. Lumajang",
                //                         style: MyFont.poppins(
                //                             fontSize: 11, color: white),
                //                       ),
                //                     ),
                //                   ),
                //             select
                //                 ? AnimatedDefaultTextStyle(
                //                     style:
                //                         MyFont.inter(fontSize: 18, color: white),
                //                     duration: Duration(seconds: 2),
                //                     child: Text(""))
                //                 : Container(
                //                     margin: EdgeInsets.only(left: 8),
                //                     height: 35,
                //                     width: 80,
                //                     child: ElevatedButton(
                //                       style: ElevatedButton.styleFrom(
                //                           backgroundColor:
                //                               primaryColor.withOpacity(0.9),
                //                           shadowColor: Colors.transparent,
                //                           shape: RoundedRectangleBorder(
                //                             borderRadius:
                //                                 BorderRadius.circular(5),
                //                           )),
                //                       onPressed: () async {
                //                         MySnackbar(
                //                                 type: SnackbarType.error,
                //                                 title: "OK")
                //                             .showSnackbar(context);
                //                       },
                //                       child: Text('Profil',
                //                           style: MyFont.poppins(
                //                               fontSize: 11, color: white)),
                //                     ),
                //                   )
                //           ],
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                ),
          ),
          SliverToBoxAdapter(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                WidgetPelayanan(),
                WidgetTextBerita(),
                WidgetBerita(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
