import 'package:crypto/crypto.dart';
import 'dart:convert';

String user = '';
String pass = '';

String sha256Encrypt(String input1, String input2) {
  String combinedInput = input1 + input2;
  var sha = sha256.convert(utf8.encode(combinedInput));
  String encryptedString = sha.toString();
  return encryptedString;
}

String sha256Encrypt1(String input1) {
  var sha = sha256.convert(utf8.encode(input1));
  String encryptedString = sha.toString();
  return encryptedString;
}

void main() {
  String input1 = "";
  String input2 = "";
  String encrypted = sha256Encrypt(input1, input2);
  String encrypted1 = sha256Encrypt1(input2);
  print("Encrypted String: $encrypted, $encrypted1");
}
