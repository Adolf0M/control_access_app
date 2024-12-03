import 'dart:convert'; // Para decodificar JSON
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrScreen extends StatefulWidget {
  final Function(Map<String, String>) onQRScanned; // Callback para enviar datos al padre

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
      appBar: AppBar(
      ),
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
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
