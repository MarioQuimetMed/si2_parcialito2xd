export 'materia.dart';

class Materia {
  final String nombre;
  final List<String> moduloAula;
  final List<String> horario;
  final String grupo;
  final List<String> dias;

  Materia({
    required this.nombre,
    required this.moduloAula,
    required this.horario,
    required this.dias,
    required this.grupo,
  });
}

class MateriaDia {
  final int id;
  final String nombre;
  final String moduloAula;
  final String horario;
  final String grupo;
  final List<String> dias;

  MateriaDia({
    required this.id,
    required this.nombre,
    required this.moduloAula,
    required this.horario,
    required this.dias,
    required this.grupo,
  });
}
