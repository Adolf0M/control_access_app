import 'dart:convert'; // Para decodificar JSON
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrScreen extends StatefulWidget {
<<<<<<< HEAD
  final Function(Map<String, String>)
      onQRScanned; // Callback para enviar datos al padre
=======
  final Function(Map<String, String>) onQRScanned; // Callback para enviar datos al padre
>>>>>>> 07bab4834e3c6e76dbd58b1da7c9ab684db15c9c

  const ScanQrScreen({required this.onQRScanned, super.key});

  @override
  _ScanQrScreenState createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? scannedMessage;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      controller!.pauseCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _flipCamera() {
    controller?.flipCamera();
  }

  void _resumeCamera() {
    controller?.resumeCamera();
  }

  void _handleQRData(String qrData) {
    try {
      final Map<String, dynamic> parsedData = jsonDecode(qrData);

      // Verificar que el JSON contenga los campos esperados
      if (parsedData.containsKey('name') &&
          parsedData.containsKey('lastName') &&
          parsedData.containsKey('email')) {
        widget.onQRScanned({
          'name': parsedData['name'],
          'lastName': parsedData['lastName'],
          'email': parsedData['email'],
        });

        setState(() {
          scannedMessage = "Datos escaneados correctamente.";
        });
      } else {
        setState(() {
          scannedMessage = "Formato de datos no válido en el QR.";
        });
      }
    } catch (e) {
      setState(() {
        scannedMessage = "Error al procesar el QR.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      appBar: AppBar(),
=======
      appBar: AppBar(
      ),
>>>>>>> 07bab4834e3c6e76dbd58b1da7c9ab684db15c9c
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (QRViewController controller) {
                this.controller = controller;
                controller.scannedDataStream.listen((scanData) {
                  if (scannedMessage != scanData.code) {
                    _handleQRData(scanData.code!);
                  }
                });
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  scannedMessage ?? 'Esperando escaneo...',
<<<<<<< HEAD
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
=======
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
>>>>>>> 07bab4834e3c6e76dbd58b1da7c9ab684db15c9c
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: _flipCamera,
                      child: const Text('Voltear Cámara'),
                    ),
                    ElevatedButton(
                      onPressed: _resumeCamera,
                      child: const Text('Reanudar Cámara'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
