import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/aluno.dart';

class AlunoInfoWidget extends StatelessWidget {
  final Aluno aluno;

  const AlunoInfoWidget({super.key, required this.aluno});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nome: ${aluno.nome}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('Número de Matrícula: ${aluno.numeroMatricula}', style: const TextStyle(fontSize: 16)),
        Text('E-mail: ${aluno.email}', style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}