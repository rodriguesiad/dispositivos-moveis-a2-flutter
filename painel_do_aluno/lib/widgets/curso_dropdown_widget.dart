import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/curso.dart';

class CursoDropdownWidget extends StatelessWidget {
  final List<Curso> cursos;
  final String? cursoSelecionado;
  final void Function(String?) onChanged;

  const CursoDropdownWidget({
    super.key,
    required this.cursos,
    required this.cursoSelecionado,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: cursoSelecionado,
      items: cursos.map((curso) {
        return DropdownMenuItem(
          value: curso.id,
          child: Text(curso.nome),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: const InputDecoration(
        labelText: "Selecione um curso",
        border: OutlineInputBorder(),
      ),
    );
  }
}