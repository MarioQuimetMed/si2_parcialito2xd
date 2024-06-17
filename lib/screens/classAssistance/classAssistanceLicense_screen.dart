import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:si2_parcialito2/api/assistence_api.dart';
import 'package:si2_parcialito2/models/materia.dart';
import 'package:si2_parcialito2/screens/classAssistance/AssistenceRealized_screen.dart';

class ClassAssistanceLicenseScreen extends StatefulWidget {
  final MateriaDia materia;
  const ClassAssistanceLicenseScreen({Key? key, required this.materia})
      : super(key: key);

  @override
  _ClassAssistanceLicenseScreenState createState() =>
      _ClassAssistanceLicenseScreenState();
}

class _ClassAssistanceLicenseScreenState
    extends State<ClassAssistanceLicenseScreen> {
  File? _image;
  final picker = ImagePicker();
  String? _message;
  bool _isLoading = false;

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    } else {
      // Si el usuario cancela la operación de la cámara, volvemos atrás en la navegación.
      Navigator.pop(context);
    }
  }

  Future<void> uploadImage() async {
    if (_image == null) {
      setState(() {
        _message = 'No has seleccionado ninguna imagen.';
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await AsistenceApi()
          .marcarAsistenciaVirtual(widget.materia.id, _image!.path);

      print('Image uploaded');
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AssistenceRealizedScreen(
            descripcion: 'Licencia solicitada Con Exito',
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _message = e.toString();
      });
      _showErrorDialog();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showErrorDialog() {
    if (_message != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(_message!),
            actions: <Widget>[
              TextButton(
                child: const Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir Comprobante'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _image == null
                    ? const Text('No has seleccionado ninguna imagen.')
                    : Image.file(
                        _image!,
                        width: 300,
                        height: 300,
                      ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  child: const Text('Tomar Foto'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  child: const Text('Seleccionar de Galería'),
                ),
                if (_image != null)
                  ElevatedButton(
                    onPressed: () async {
                      await uploadImage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text('Subir Comprobante',
                        style: TextStyle(color: Colors.white)),
                  ),
              ],
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
