import 'package:flutter/material.dart';
import 'dart:async';

class AssistenceRealizedScreen extends StatelessWidget {
  final String descripcion;

  AssistenceRealizedScreen({super.key, required this.descripcion});

  @override
  Widget build(BuildContext context) {
    // Configura la navegación automática después de 5 segundos
    Timer(const Duration(seconds: 5), () {
      Navigator.pushNamed(context,
          '/asistencia'); // Cambia '/targetPage' por la ruta de la página deseada
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100.0,
            ),
            const SizedBox(height: 20),
            Text(
              descripcion,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context,
                    '/asistencia'); // Cambia '/menu' por la ruta del menú
              },
              child: const Text('Volver al Menú'),
            ),
          ],
        ),
      ),
    );
  }
}
