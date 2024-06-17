import 'package:flutter/material.dart';

class NoHorarioWidget extends StatelessWidget {
  final String titulo;
  final String descripcion;

  const NoHorarioWidget(
      {super.key, required this.titulo, required this.descripcion});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.alarm_off,
            color: Colors.red[300],
            size: 100.0,
          ),
          SizedBox(height: 20),
          Text(
            titulo,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 10),
          Text(
            descripcion,
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
