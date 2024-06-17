import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:si2_parcialito2/api/assistence_api.dart';
import 'package:si2_parcialito2/models/materia.dart';
import 'package:si2_parcialito2/screens/classAssistance/AssistenceRealized_screen.dart';

class ClassAssistanceVirtualScreen extends StatefulWidget {
  final MateriaDia materia;
  const ClassAssistanceVirtualScreen({Key? key, required this.materia})
      : super(key: key);

  @override
  _ClassAssistanceVirtualScreenState createState() =>
      _ClassAssistanceVirtualScreenState();
}

class _ClassAssistanceVirtualScreenState
    extends State<ClassAssistanceVirtualScreen> {
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
      _showErrorDialog();
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
            descripcion: 'Comprobante Enviado Con Exito!',
          ),
        ),
      );
    } catch (e) {
      print(e);
      print(e.toString());
      setState(() {
        _message = _parseErrorMessage(e.toString());
      });
      _showErrorDialog();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _parseErrorMessage(String error) {
    // Aquí puedes realizar más procesamiento del error para hacerlo más amigable.
    if (error.contains('SocketException')) {
      return 'No se puede conectar al servidor. Por favor, revisa tu conexión a internet e inténtalo nuevamente.';
    } else if (error.contains('Error')) {
      String errorMessage = error.toString();
      errorMessage = errorMessage.replaceFirst('Exception: Error: ', '');
      errorMessage = errorMessage.replaceAll('[', '');
      errorMessage = errorMessage.replaceAll(']', '');
      print(errorMessage);
      return errorMessage;
    }
    return 'Ocurrió un error inesperado. Por favor, inténtalo de nuevo.';
  }

  void _showErrorDialog() {
    if (_message != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Row(
              children: [
                Icon(Icons.error, color: Colors.red),
                SizedBox(width: 10),
                Text('Error', style: TextStyle(color: Colors.red)),
              ],
            ),
            content: Text(
              _message!,
              style: const TextStyle(fontSize: 16),
            ),
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
                    child: const Text('Subir Comprobante'),
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
