import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'package:painel_do_aluno/models/matricula.dart';

class BoletimCard extends StatelessWidget {
  final Disciplina disciplina;
  final Matricula? matricula;

  const BoletimCard({
    super.key,
    required this.disciplina,
    required this.matricula,
  });

  @override
  Widget build(BuildContext context) {
    final m =
        matricula ??
        Matricula(
          id: '',
          disciplinaId: '',
          alunoId: '',
          faltas: 0,
          a1: null,
          a2: null,
          exameFinal: null,
          mediaSemestral: null,
          mediaFinal: null,
          situacao: 'NÃO MATRICULADO',
          semestreAtual: false,
        );

    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                disciplina.nome,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text("Faltas: ${m.faltas}"),
              Text("A1: ${m.a1 != null ? m.a1!.toStringAsFixed(1) : '-'}"),
              Text("A2: ${m.a2 != null ? m.a2!.toStringAsFixed(1) : '-'}"),
              Text(
                "Exame Final: ${m.exameFinal != null ? m.exameFinal!.toStringAsFixed(1) : '-'}",
              ),
              Text(
                "Média Final: ${m.mediaSemestral != null ? m.mediaSemestral!.toStringAsFixed(1) : '-'}",
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text("Situação: "),
                  Text(
                    m.situacao,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          m.situacao == 'APROVADO'
                              ? Colors.green
                              : m.situacao == 'REPROVADO'
                              ? Colors.red
                              : Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
