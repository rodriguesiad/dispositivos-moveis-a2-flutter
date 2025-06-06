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

  factory MatriculaDisciplina.fromJson(Map<String, dynamic> json) {
    return MatriculaDisciplina(
      id: json['id'],
      disciplinaId: json['disciplinaId'],
      alunoId: json['alunoId'],
      faltas: json['faltas'],
      a1: json['a1'],
      a2: json['a2'],
      exameFinal: json['exameFinal'],
      mediaSemestral: json['mediaSemestral'],
      mediaFinal: json['mediaFinal'],
      situacao: json['situacao'],
      semestreAtual: json['semestreAtual'],
    );
  }
}
