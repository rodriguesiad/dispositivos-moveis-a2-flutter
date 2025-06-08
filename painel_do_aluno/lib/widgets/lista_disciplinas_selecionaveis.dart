import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/disciplina.dart';

class ListaDisciplinasSelecionaveis extends StatelessWidget {
  final List<Disciplina> disciplinasDisponiveis;
  final List<Disciplina> disciplinasSelecionadas;
  final void Function(Disciplina disciplina, bool selecionada) onSelecionar;

  const ListaDisciplinasSelecionaveis({
    super.key,
    required this.disciplinasDisponiveis,
    required this.disciplinasSelecionadas,
    required this.onSelecionar,
  });

  @override
  Widget build(BuildContext context) {
    if (disciplinasDisponiveis.isEmpty) {
      return const Center(
        child: Text(
          'Nenhuma disciplina disponível para rematrícula.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      itemCount: disciplinasDisponiveis.length,
      itemBuilder: (context, index) {
        final disciplina = disciplinasDisponiveis[index];
        final selecionada = disciplinasSelecionadas.contains(disciplina);

        return CheckboxListTile(
          title: Text(disciplina.nome),
          subtitle: Text("Carga Horária: ${disciplina.cargaHoraria}h"),
          value: selecionada,
          onChanged: (bool? value) {
            onSelecionar(disciplina, value ?? false);
          },
        );
      },
    );
  }
}
