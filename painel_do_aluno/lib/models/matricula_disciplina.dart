class MatriculaDisciplina {
  final String id;
  final String disciplinaId;
  final String alunoId;
  final int faltas;
  final double a1;
  final double a2;
  final double? exameFinal;
  final double mediaSemestral;
  final double? mediaFinal;
  final String situacao;
  final bool semestreAtual;

  MatriculaDisciplina({
    required this.id,
    required this.disciplinaId,
    required this.alunoId,
    required this.faltas,
    required this.a1,
    required this.a2,
    this.exameFinal,
    required this.mediaSemestral,
    this.mediaFinal,
    required this.situacao,
    required this.semestreAtual,
  });
}
