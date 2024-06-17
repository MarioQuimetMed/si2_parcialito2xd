import 'package:flutter/material.dart';
import 'package:si2_parcialito2/api/horary_api.dart';
import 'package:si2_parcialito2/models/classResponse.dart';
import 'package:si2_parcialito2/models/materia.dart';
import 'package:si2_parcialito2/screens/classAssistance/classAsistanceMark_screen.dart';
import 'package:si2_parcialito2/screens/classAssistance/scan_qr_screen.dart';
import 'package:si2_parcialito2/widgets/noExisteWidget.dart';
import 'package:si2_parcialito2/widgets/tittle_widget.dart'; // Necesitarás esta librería para obtener el día actual

class ClassAssistanceScreen extends StatefulWidget {
  ClassAssistanceScreen({super.key});

  @override
  State<ClassAssistanceScreen> createState() => _ClassAssistanceScreenState();
}

class _ClassAssistanceScreenState extends State<ClassAssistanceScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<MateriaDia> materias = [
    MateriaDia(
      id: 20,
      nombre: 'Sistema de informacion 1',
      moduloAula: 'Aula 1',
      grupo: 'SA',
      horario: '8:00 - 10:00',
      dias: ['Lunes', 'Miércoles'],
    ),
    MateriaDia(
      id: 21,
      nombre: 'Base de datos 2 SA',
      moduloAula: 'Aula 2',
      horario: '8:00 - 10:00',
      grupo: 'SA',
      dias: ['Martes'],
    ),
  ];

  Future<void> getClasses() async {
    //hacer algo digamos que se obtiene de una api
    final clases = await HoraryApi().getClass();
    print('--------------Clases------------------');
    final xd = ClassResponse.getClasses(clases);
    // final xd = HoraryResponse.getHorario(horario, horario);
    this.materias = xd;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getClasses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const NoHorarioWidget(
                titulo: 'No hay clases',
                descripcion: 'El docente no tiene mas clases por hoy.');
          } else {
            // Aquí debes retornar el widget que quieres mostrar cuando getClasses() se complete
            // Por ejemplo, si getClasses() devuelve una lista de clases, puedes mostrarlas en un ListView
            return ListaClases(materias: materias);
          }
        },
      ),
    );
  }
}

class ListaClases extends StatelessWidget {
  const ListaClases({
    super.key,
    required this.materias,
  });

  final List<MateriaDia> materias;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TituloWidget(titulo: 'Asistencias'),
          Expanded(
            child: ListView.builder(
              itemCount: materias.length,
              itemBuilder: (context, index) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20),
                    title: Text(
                      materias[index].nombre,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.class_,
                                color: Colors.blue, size: 16),
                            const SizedBox(width: 5),
                            Text(
                              'Aula: ${materias[index].moduloAula}',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.schedule,
                                color: Colors.blue, size: 16),
                            const SizedBox(width: 5),
                            Text(
                              'Horario: ${materias[index].horario}',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.group,
                                color: Colors.blue, size: 16),
                            const SizedBox(width: 5),
                            Text(
                              'Grupo: ${materias[index].grupo.toUpperCase()}',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        // Text('id: ${materias[index].id}'),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.teal,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClassAssistanceMark(
                            materia: materias[index],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
