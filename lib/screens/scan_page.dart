import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

const bgColor = Color(0xfffafafa);

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey _qrKey = GlobalKey();
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
            child: QRView(
              key: _qrKey,
              onQRViewCreated: (controller) {
                _controller = controller;
                controller.scannedDataStream.listen((scanData) {
                  // Handle the scanned QR code data here
                  print(scanData);
                });
              },
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: const Text(
                "Sabrang 2023",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1,
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
