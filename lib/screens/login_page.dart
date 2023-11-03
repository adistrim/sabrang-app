import 'package:flutter/material.dart';
import 'package:my_app/screens/scan_page.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

String username = '';
String password = '';
String host = '';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  String sha256Encrypt(String input1) {
    var sha = sha256.convert(utf8.encode(input1));
    String encryptedString = sha.toString();
    return encryptedString;
  }

  Future<void> moveToHome(BuildContext context, String username, String password, String host) async {
    final storage = new FlutterSecureStorage();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('host', host);
    final String loginUrl = host + '/api/login/';

    final Map<String, String> data = {
    'username': username,
    'password': password,
    };

    try {
      final response = await http.post(
        Uri.parse(loginUrl),
        body: data,
      );
    if (response.statusCode == 200) {
      await storage.write(key: 'access_token', value: jsonDecode(response.body)['access']);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ScanPage(),
        ),
      );

    } else {
      // Handle login failure (e.g., display an error message).
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect password'),
        ),
      );
    }
    }
    catch (e) {
      print(e);
    }
    
    // final encryptedUsername = sha256Encrypt(username);
    // final encryptedPassword = sha256Encrypt(password);
    // final input = encryptedUsername + encryptedPassword;
    // const customPassword = '0fdcd1d0c7348f31e94d90d5ef4b6a23bac7617073ffe25af5d71062976e6059';

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Ticketify',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Host',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onChanged: (value) {
                  host = value;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onChanged: (value) {
                  username = value;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onChanged: (value) {
                  password = value;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  // Add your login logic here
                  moveToHome(context, username, password, host);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Background color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25, vertical: 12), // Padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(15.0), // Rounded corners
                  ),
                ),
                child: const Text(
                  'Log In',
                  style: TextStyle(
                    fontSize: 18, // Text size
                    color: Colors.white, // Text color
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
