import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const bgColor = Color(0xfffafafa);

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey _qrKey = GlobalKey();
  Barcode? result;
  late QRViewController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Quick QR Scanner",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          const Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Place the QR code in the area",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Scanning will start automatically",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                QRView(
                  key: _qrKey,
                  onQRViewCreated: (controller) {
                    _controller = controller;
                    controller.scannedDataStream.listen((scanData) {
                      setState(() {
                        result = scanData;
                      });

                      if (result != null && result?.code != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result!.code!),
                          ),
                        );
                      } else {
                        // Handle the case when result or result.code is null
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Invalid QR code data'),
                          ),
                        );
                      }
                    });
                  },
                ),
                QRScannerOverlay(overlayColor: bgColor),
              ],
            ),
          ),

        ]),
      ),
    );
  }

  Future<void> send_data(String result) async {
    final prefs = await SharedPreferences.getInstance();
    final storage = new FlutterSecureStorage();
    String? value = await storage.read(key: 'access_token');
    final String? host = prefs.getString('host');
    // final String endpoint = host + '/api/ticket/handle_check_in/';
    final Map<String, String> data = {
    'ticket_id': result,
    };

    // try {
      // final response = await http.post(
        // Uri.parse(endpoint),
        // body: data,
      // );
    // if (response.statusCode == 200) {
      

    // } else {
      // Handle login failure (e.g., display an error message).
    // }
    // }
    // catch (e) {
      // print(e);
    // }
    
  }

}
