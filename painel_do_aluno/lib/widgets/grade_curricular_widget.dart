// grade_curricular_widget.dart
import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'disciplina_card.dart';

class GradeCurricularWidget extends StatelessWidget {
  final Map<String, List<Disciplina>> disciplinasPorPeriodo;

  const GradeCurricularWidget({super.key, required this.disciplinasPorPeriodo});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: disciplinasPorPeriodo.keys.map<Widget>((periodo) {
        final disciplinas = disciplinasPorPeriodo[periodo]!;
        return ExpansionTile(
          title: Text("Período $periodo"),
          children: disciplinas.map((d) => DisciplinaCard(disciplina: d)).toList(),
        );
      }).toList(),
    );
  }
}