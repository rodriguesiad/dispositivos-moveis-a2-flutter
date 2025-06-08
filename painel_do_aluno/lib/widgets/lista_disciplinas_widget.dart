import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/disciplina.dart';

class ListaDisciplinasWidget extends StatelessWidget {
  final String titulo;
  final List<Disciplina> disciplinas;

  const ListaDisciplinasWidget({
    super.key,
    required this.titulo,
    required this.disciplinas,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      color: Colors.indigo[50],
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titulo,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...disciplinas.map(
              (disciplina) => ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(disciplina.nome),
                subtitle: Text("Carga Horária: ${disciplina.cargaHoraria}h"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
