import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/aluno.dart';

class AlunoInfoWidget extends StatelessWidget {
  final Aluno aluno;

  const AlunoInfoWidget({super.key, required this.aluno});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          initialValue: aluno.nome,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Nome',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: aluno.numeroMatricula,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'Número de Matrícula',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 12),
        TextFormField(
          initialValue: aluno.email,
          readOnly: true,
          decoration: const InputDecoration(
            labelText: 'E-mail',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}