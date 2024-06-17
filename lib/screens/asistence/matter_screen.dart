import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:si2_parcialito2/models/materia.dart';
import 'package:si2_parcialito2/screens/classAssistance/scan_qr_screen.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class MatterDetailPage extends StatefulWidget {
  final Materia materia;
  final List<String> dias;

  const MatterDetailPage({Key? key, required this.materia, required this.dias})
      : super(key: key);

  @override
  _MatterDetailPageState createState() => _MatterDetailPageState();
}

class _MatterDetailPageState extends State<MatterDetailPage> {
  late Future<DateTime> _currentDate;
  late List<DateTime> _nearestDates;

  @override
  void initState() {
    super.initState();
    _currentDate = _getCurrentDate();
    _currentDate.then((value) {
      setState(() {
        _nearestDates = getNearestDates(value, widget.dias);
        _nearestDates.sort((a, b) => a.compareTo(b));
      });
    });
  }

  List<DateTime> getNearestDates(
      DateTime currentDate, List<String> targetWeekdays) {
    List<DateTime> nearestDates = [];

    _getNearestDatesRecursively(currentDate, targetWeekdays, nearestDates);

    return nearestDates;
  }

  void _getNearestDatesRecursively(DateTime currentDate,
      List<String> targetWeekdays, List<DateTime> nearestDates) {
    if (nearestDates.length >= 5) {
      return;
    }

    for (final weekday in targetWeekdays) {
      DateTime nearestDay = _getNearestDay(currentDate, weekday);

      if (!nearestDates.contains(nearestDay) &&
          !nearestDay.isBefore(currentDate)) {
        nearestDates.add(nearestDay);
      }
    }

    _getNearestDatesRecursively(
        currentDate.add(Duration(days: 7)), targetWeekdays, nearestDates);
  }

  Future<DateTime> _getCurrentDate() async {
    tz.initializeTimeZones();
    final String timezone = 'America/La_Paz';
    final response = await http
        .get(Uri.parse('http://worldtimeapi.org/api/ip?timezone=$timezone'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final dateTime =
          tz.TZDateTime.parse(tz.getLocation(timezone), data['datetime']);
      return dateTime;
    } else {
      throw Exception('Failed to load current date');
    }
  }

  DateTime _getNearestDay(DateTime currentDate, String targetWeekday) {
    int targetWeekdayIndex = _getWeekdayIndex(targetWeekday);
    int difference = targetWeekdayIndex - currentDate.weekday;
    if (difference <= 0) {
      difference += 7;
    }
    DateTime nearestDay = currentDate.add(Duration(days: difference));
    return nearestDay;
  }

  int _getWeekdayIndex(String weekday) {
    switch (weekday.toLowerCase()) {
      case 'lunes':
        return 1;
      case 'martes':
        return 2;
      case 'miércoles':
        return 3;
      case 'jueves':
        return 4;
      case 'viernes':
        return 5;
      case 'sábado':
        return 6;
      case 'domingo':
        return 7;
      default:
        throw Exception('Invalid weekday');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles de ${widget.materia.nombre}')),
      body: FutureBuilder<DateTime>(
        future: _currentDate,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: _nearestDates.length,
              itemBuilder: (context, index) {
                final date = _nearestDates[index];
                final eslaPrimera = index == 0;
                return ListTile(
                  title: ElevatedButton(
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => ScanQrScreenPage(date: date),
                      //   ),
                      // );
                    },
                    child: Text(
                        'Detalles para el ${date.day}/${date.month}/${date.year}'),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            eslaPrimera ? Colors.green : Colors.white)),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class AssistenceDetail extends StatelessWidget {
  final List<DateTime> dates;

  const AssistenceDetail({Key? key, required this.dates}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles de Asistencia')),
      body: Center(
        child: ListView.builder(
          itemCount: dates.length,
          itemBuilder: (BuildContext context, int index) {
            DateTime date = dates[index];
            return Text(
              'Detalles para el ${date.day}/${date.month}/${date.year}',
              style: TextStyle(fontSize: 24),
            );
          },
        ),
      ),
    );
  }
}
