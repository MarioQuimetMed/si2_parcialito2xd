import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:si2_parcialito2/api/assistence_api.dart';
import 'package:si2_parcialito2/models/materia.dart';
import 'package:si2_parcialito2/screens/classAssistance/AssistenceRealized_screen.dart';
import 'package:si2_parcialito2/screens/menu_screen.dart';

class ScanQrScreenPage extends StatefulWidget {
  final MateriaDia? materia;
  const ScanQrScreenPage({super.key, required this.materia});

  @override
  State<ScanQrScreenPage> createState() => _ScanQrScreenPageState();
}

class _ScanQrScreenPageState extends State<ScanQrScreenPage> {
  late MobileScannerController _controller;
  bool isMarked = false;
  bool isScanned = false;
  String? _messageError = null;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController(
        detectionSpeed: DetectionSpeed.normal, returnImage: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> marcarAsistencia(int? idClase, String codigoQR) async {
    // Lógica para marcar asistencia
    if (idClase == null) {
      return;
    }
    try {
      final response = await AsistenceApi().marcarAsistencia(idClase, codigoQR);
      isScanned = true;
      print(response);
      isMarked = true;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AssistenceRealizedScreen(
            descripcion: 'Asistencia Marcada Con Exito',
          ),
        ),
      );
      // dispose();
    } catch (e) {
      _messageError = e.toString();
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () => _controller.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.camera_alt),
            onPressed: () => _controller.switchCamera(),
          ),
        ],
      ),
      body: MobileScanner(
        controller: _controller,
        onDetect: (barcodeCapture) async {
          final String code = barcodeCapture.barcodes.first.rawValue ?? '---';
          if (!isScanned) {
            isScanned = true;
            _controller.stop();
            await marcarAsistencia(widget.materia?.id, code);
            print('----------------LLAMADA API---------------');
          }
          // Detiene el escáner después de que se detecta un código QR
          if (!isMarked) {
            if (mounted) {
              // Verifica si el widget todavía está montado
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Asistencia'),
                    content: Text(_messageError != null
                        ? _messageError!
                        : 'No se ha podido marcar la asistencia.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cerrar'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/menu');
                        },
                      ),
                    ],
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
