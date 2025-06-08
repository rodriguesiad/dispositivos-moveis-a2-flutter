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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(titulo, style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 8),
        ...disciplinas.map((disciplina) => ListTile(
              title: Text(disciplina.nome),
              subtitle: Text("Carga Horária: ${disciplina.cargaHoraria}h"),
            )),
      ],
    );
  }
}
