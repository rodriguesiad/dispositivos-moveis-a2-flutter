import 'package:flutter/material.dart';

class ProgressoCursoWidget extends StatelessWidget {
  final double progresso;

  const ProgressoCursoWidget({super.key, required this.progresso});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Progresso do Curso: ${progresso.toStringAsFixed(1)}%",
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 10),
        LinearProgressIndicator(
          value: progresso / 100,
          minHeight: 8,
          backgroundColor: Colors.grey[300],
          color: Colors.green,
        ),
      ],
    );
  }
}
