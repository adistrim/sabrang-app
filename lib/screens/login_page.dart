import 'package:flutter/material.dart';
import 'package:my_app/screens/scan_page.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

String username = '';
String password = '';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  String sha256Encrypt(String input1) {
    var sha = sha256.convert(utf8.encode(input1));
    String encryptedString = sha.toString();
    return encryptedString;
  }

  void moveToHome(BuildContext context, String username, String password) {
    final encryptedUsername = sha256Encrypt(username);
    final encryptedPassword = sha256Encrypt(password);
    final input = encryptedUsername + encryptedPassword;
    const customPassword = '0fdcd1d0c7348f31e94d90d5ef4b6a23bac7617073ffe25af5d71062976e6059';

    final encryptInput = sha256Encrypt(input);

    if (encryptInput == customPassword) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const ScanPage(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Incorrect password'),
        ),
      );
    }
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
              // TextFormField(
              //   decoration: InputDecoration(
              //     hintText: 'Host',
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(16),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 12),
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
                  moveToHome(context, username, password);
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
