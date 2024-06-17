import 'package:flutter/material.dart';
import 'package:si2_parcialito2/api/horary_api.dart';
import 'package:si2_parcialito2/models/horaryResponse.dart';
import 'package:si2_parcialito2/models/materia.dart';
import 'package:si2_parcialito2/screens/asistence/matter_screen.dart';
import 'package:si2_parcialito2/widgets/noExisteWidget.dart';
import 'package:si2_parcialito2/widgets/tittle_widget.dart';

class AssistenceScreenPage extends StatefulWidget {
  const AssistenceScreenPage({super.key});

  @override
  State<AssistenceScreenPage> createState() => _AssistenceScreenPageState();
}

class _AssistenceScreenPageState extends State<AssistenceScreenPage>
    with AutomaticKeepAliveClientMixin {
  late List<Materia> materias;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> getMatters() async {
    final horario = await HoraryApi().getHorary();
    print('--------------Horario------------------');
    final xd = HoraryResponse.getHorario(horario, horario);
    this.materias = xd;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getMatters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return NoHorarioWidget(
              titulo: 'No hay Materias disponibles',
              descripcion:
                  'El docente no tiene Materias asignadas en este momento.',
            ); // Muestra un mensaje de error si hay un error
          } else {
            return Column(
              children: [
                const TituloWidget(
                  titulo: 'Materias',
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: materias.length,
                    itemBuilder: (context, index) {
                      return CardMateria(materias: materias, index: index);
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class CardMateria extends StatelessWidget {
  const CardMateria({
    super.key,
    required this.materias,
    required this.index,
  });

  final List<Materia> materias;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Añade una sombra para dar profundidad al card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            12), // Bordes redondeados para un aspecto más suave
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 16, horizontal: 20), // Espaciado interno
        leading: const Icon(Icons.bookmark,
            color: Colors.blue), // Icono a la izquierda del título
        title: Text(
          '${materias[index].nombre} - ${materias[index].grupo.toUpperCase()}',
          style: const TextStyle(
            fontSize: 18, // Tamaño del texto
            fontWeight: FontWeight.bold, // Texto en negrita para resaltar
            color: Colors.black87, // Color del texto
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Colors.blue), // Icono a la derecha del card
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MatterDetailPage(
                  materia: materias[index], dias: materias[index].dias),
            ),
          );
        },
      ),
    );
  }
}
