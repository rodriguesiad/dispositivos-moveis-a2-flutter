// lib/service/helpers/boletim_helper.dart
import 'package:painel_do_aluno/models/disciplina.dart';
import 'package:painel_do_aluno/models/matricula.dart';

List<Disciplina> filtrarDisciplinasDoCursoAtivo(
  String cursoId,
  List<Disciplina> disciplinas,
  List<Matricula> matriculas,
) {
  return disciplinas.where((disciplina) {
    final estaMatriculado = matriculas.any(
      (matricula) =>
          matricula.disciplinaId == disciplina.id &&
          matricula.semestreAtual,
    );
    return disciplina.cursoId == cursoId && estaMatriculado;
  }).toList();
}
