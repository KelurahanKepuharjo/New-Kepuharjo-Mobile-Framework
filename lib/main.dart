import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_kepuharjo_new/Dashboard_Rt/Drawer/select.dart';
import 'package:mobile_kepuharjo_new/Dashboard_User/dashboard_user.dart';
import 'package:mobile_kepuharjo_new/Services/local_notifications_services.dart';
import 'package:mobile_kepuharjo_new/Wellcome/onboarding.dart';
import 'package:mobile_kepuharjo_new/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> _backgroundMessageHandler(RemoteMessage message) async {
  // Notifikasi diterima saat aplikasi ditutup (terminated)
  print(
      "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.title}");
  print(
      "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.body}");
  LocalNotificationsServices.showNotificationForeground(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  LocalNotificationsServices.initialized();
  // FirebaseMessaging.instance.subscribeToTopic('all');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(ChangeNotifierProvider(
      create: (_) => SelectedPage(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  String _userRole = '';
  void _checkIfLoggedIn() async {
    // check if token is there
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      var userJson = localStorage.getString('user');
      var role = localStorage.getString('role');
      var user = json.decode(userJson!);
      setState(() {
        _isLoggedIn = true;
        _userRole = role!;
      });
    }
  }

  Future<String> _getUserRole() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('role');
    return userJson.toString();
  }

  void configureFirebaseMessaging() {
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        // Notifikasi diterima saat aplikasi dibuka dari background (terminated)
        print(
            "Notifikasi diterima saat aplikasi dibuka dari background (terminated): ${message.notification?.title}");
        print(
            "Notifikasi diterima saat aplikasi dibuka dari background (terminated): ${message.notification?.body}");
        LocalNotificationsServices.showNotificationForeground(message);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Notifikasi diterima saat aplikasi berjalan di foreground
      print(
          "Notifikasi diterima saat aplikasi berjalan di foreground: ${message.notification?.title}");
      print(
          "Notifikasi diterima saat aplikasi berjalan di foreground: ${message.notification?.body}");
      LocalNotificationsServices.showNotificationForeground(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Notifikasi diterima saat aplikasi dibuka dari background (background running)
      print(
          "Notifikasi diterima saat aplikasi dibuka dari background (background running): ${message.notification?.title}");
      print(
          "Notifikasi diterima saat aplikasi dibuka dari background (background running): ${message.notification?.body}");
      LocalNotificationsServices.showNotificationForeground(message);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SplashScreen(),
          ));
    });

    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }

  Future<void> _backgroundMessageHandler(RemoteMessage message) async {
    // Notifikasi diterima saat aplikasi ditutup (terminated)
    print(
        "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.title}");
    print(
        "Notifikasi diterima saat aplikasi ditutup (terminated): ${message.notification?.body}");
    LocalNotificationsServices.showNotificationForeground(message);
  }

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
    configureFirebaseMessaging();
    LocalNotificationsServices.initialized();
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
    requestPermissions();
    // FirebaseMessaging.instance.subscribeToTopic('all');
  }

  late PermissionStatus _notificationStatus;
  late PermissionStatus _storageStatus;

  Future<void> requestPermissions() async {
    // Request notification permission
    final notificationStatus = await Permission.notification.request();
    setState(() {
      _notificationStatus = notificationStatus;
    });

    // Request external storage permission
    final storageStatus = await Permission.storage.request();
    setState(() {
      _storageStatus = storageStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'S-Kepuharjo',
        themeMode: ThemeMode.system,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreen());
  }
}
