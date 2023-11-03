import 'package:flutter/material.dart';
import 'package:my_app/screens/login_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:my_app/screens/scan_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget buildHome() {
  if (CheckLogin() == true) {
    return const ScanPage();
  } else {
    return const LoginPage();
  }
}

void main() {
  runApp(const MyApp());
}

Future<bool> CheckLogin() async {
  final prefs = await SharedPreferences.getInstance();
  final storage = new FlutterSecureStorage();
  String? value = await storage.read(key: 'access_token');
  final String? host = prefs.getString('host');
  if (value != null && host != null) {
    return true;
  } else {
    return false;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
      home: buildHome(),
    );
  }
}
