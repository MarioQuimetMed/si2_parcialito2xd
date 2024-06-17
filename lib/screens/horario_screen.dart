import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:si2_parcialito2/api/horary_api.dart';
import 'package:si2_parcialito2/models/horaryResponse.dart';
import 'package:si2_parcialito2/widgets/noExisteWidget.dart';
import 'package:si2_parcialito2/widgets/tittle_widget.dart';

import '../models/materia.dart';

class HorarioScreenPage extends StatefulWidget {
  HorarioScreenPage({super.key});

  static const dias = [
    'Lunes',
    'Martes',
    'Miercoles',
    'Jueves',
    'Viernes',
    'Sabado'
  ];
  // Lista de materias para cada día
  static List<Materia> materiasPorDia = [
    Materia(
      nombre: 'Sistema de informacion 1',
      moduloAula: ['Aula 1'],
      grupo: 'SA',
      horario: ['8:00 - 10:00'],
      dias: ['Lunes', 'Miércoles'],
    ),
    Materia(
      nombre: 'Base de datos 2 SA',
      moduloAula: ['Aula 1'],
      horario: ['18:00 - 20:00'],
      grupo: 'SA',
      dias: ['Martes'],
    ),
    Materia(
      nombre: 'Ingenieria de Software 1',
      moduloAula: ['Aula 1'],
      horario: ['8:00 - 10:00'],
      grupo: 'SB',
      dias: ['Martes', 'Jueves'],
    ),
  ];

  setmateriasPorDia(List<Materia> materias) {
    materiasPorDia = materias;
  }

  getmateriasPorDia() {
    return materiasPorDia;
  }

  @override
  State<HorarioScreenPage> createState() => _HorarioScreenPageState();
}

class _HorarioScreenPageState extends State<HorarioScreenPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
  }

  List<Materia> materiasDoc = [];

  Future<void> getHorary() async {
    final horario = await HoraryApi().getHorary();
    print('--------------Horario------------------');
    final xd = HoraryResponse.getHorario(horario, horario);
    print(xd);
    this.materiasDoc = xd;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<void>(
          future: getHorary(), // Asegúrate de que esto devuelva un Future
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child:
                      CircularProgressIndicator()); // Muestra un círculo de carga mientras se espera
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return const NoHorarioWidget(
                titulo: 'No hay horario disponible',
                descripcion:
                    'El docente no tiene un horario asignado en este momento.',
              ); // Muestra un mensaje de error si hay un error
            } else {
              return ListView(
                // Muestra la lista una vez que los datos estén listos
                children: [
                  const TituloWidget(titulo: 'Horario'),
                  DiasMateriasWidget(materias: materiasDoc),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class DiasMateriasWidget extends StatelessWidget {
  List<Materia> materias;
  DiasMateriasWidget({super.key, required this.materias});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: HorarioScreenPage.dias.map((dia) {
        final materiasDelDia =
            materias.where((materia) => materia.dias.contains(dia)).toList();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              alignment: Alignment.center,
              width: width * 0.25,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  dia,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: materiasDelDia.map((materia) {
                int diaIndex = materia.dias.indexOf(dia);
                String horarioDia =
                    diaIndex != -1 ? materia.horario[diaIndex] : "No definido";
                String aula = diaIndex != -1
                    ? materia.moduloAula[diaIndex]
                    : "No definido";
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          materia.nombre,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            const Icon(Icons.class_,
                                color: Colors.blue, size: 16),
                            const SizedBox(width: 5),
                            Text(
                              'Aula: $aula',
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
                              'Horario: $horarioDia',
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
                              'Grupo: ${materia.grupo.toUpperCase()}',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      }).toList(),
    );
  }
}
