import 'package:flutter/material.dart';

class ProgressoCursoWidget extends StatelessWidget {
  final double progresso;

  const ProgressoCursoWidget({super.key, required this.progresso});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.indigo[900],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Progresso do Curso: ${progresso.toStringAsFixed(1)}%",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: progresso / 100,
              minHeight: 8,
              backgroundColor: Colors.grey[300],
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
