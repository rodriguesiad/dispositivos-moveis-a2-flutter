// grade_curricular_widget.dart
import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'disciplina_card.dart';

class GradeCurricularWidget extends StatefulWidget {
  final Map<String, List<Disciplina>> disciplinasPorPeriodo;

  const GradeCurricularWidget({super.key, required this.disciplinasPorPeriodo});

  @override
  State<GradeCurricularWidget> createState() => _GradeCurricularWidgetState();
}

class _GradeCurricularWidgetState extends State<GradeCurricularWidget> {
  late Map<String, bool> _expansionState;

  @override
  void initState() {
    super.initState();
    // Deixa todos os períodos expandidos por padrão
    _expansionState = {
      for (var key in widget.disciplinasPorPeriodo.keys) key: true,
    };
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:
          widget.disciplinasPorPeriodo.keys.map((periodo) {
            final disciplinas = widget.disciplinasPorPeriodo[periodo]!;

            return ExpansionTile(
              title: Text(
                periodo,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              initiallyExpanded: _expansionState[periodo] ?? false,
              onExpansionChanged: (expanded) {
                setState(() {
                  _expansionState[periodo] = expanded;
                });
              },
              children:
                  disciplinas
                      .map((d) => DisciplinaCard(disciplina: d))
                      .toList(),
            );
          }).toList(),
    );
  }
}
