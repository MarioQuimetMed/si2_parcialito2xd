import 'package:flutter/material.dart';
import 'package:si2_parcialito2/models/materia.dart';
import 'package:si2_parcialito2/screens/classAssistance/classAssistanceLicense_screen.dart';
import 'package:si2_parcialito2/screens/classAssistance/classAssistanceVirtual_screen.dart';
import 'package:si2_parcialito2/screens/classAssistance/scan_qr_screen.dart';

class ClassAssistanceMark extends StatefulWidget {
  final MateriaDia materia;
  const ClassAssistanceMark({super.key, required this.materia});

  @override
  _ClassAssistanceMarkState createState() => _ClassAssistanceMarkState();
}

class _ClassAssistanceMarkState extends State<ClassAssistanceMark> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Marcar Asistencia'),
          backgroundColor: Colors.cyan[800],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Materia: ${widget.materia.nombre}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Tipo de asistencia:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // _attendanceType = 'presencial';
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScanQrScreenPage(
                                materia: widget.materia,
                              ),
                            ),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'Presencial',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          // _attendanceType = 'virtual';
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ClassAssistanceVirtualScreen(
                                materia: widget.materia,
                              ),
                            ),
                          );
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: Colors.grey),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: const Text(
                        'Virtual',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              const Text(
                'Opciones adicionales:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Lógica para pedir licencia
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ClassAssistanceLicenseScreen(
                          materia: widget.materia,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.time_to_leave, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Pedir Licencia',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
