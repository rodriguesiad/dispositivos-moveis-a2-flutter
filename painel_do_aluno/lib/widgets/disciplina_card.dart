// disciplina_card.dart
import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/disciplina.dart';

class DisciplinaCard extends StatelessWidget {
  final Disciplina disciplina;

  const DisciplinaCard({super.key, required this.disciplina});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(
        vertical: 4,
      ), 
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, 
        children: [
          Text(
            disciplina.nome,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Text("Carga Horária: ${disciplina.cargaHoraria}h"),
        ],
      ),
    );
  }
}
