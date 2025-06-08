class Matricula {
  final String id;
  final String disciplinaId;
  final String alunoId;
  final int faltas;
  final double? a1;
  final double? a2;
  final double? exameFinal;
  final double? mediaSemestral;
  final double? mediaFinal;
  final String situacao;
  final bool semestreAtual;

  Matricula({
    required this.id,
    required this.disciplinaId,
    required this.alunoId,
    required this.faltas,
    this.a1,
    this.a2,
    this.exameFinal,
    this.mediaSemestral,
    this.mediaFinal,
    required this.situacao,
    required this.semestreAtual,
  });

  factory Matricula.fromJson(Map<String, dynamic> json) {
    return Matricula(
      id: json['id'].toString(),
      disciplinaId: json['disciplinaId'].toString(),
      alunoId: json['alunoId'].toString(),
      faltas: json['faltas'] ?? 0,
      a1: (json['a1'] as num?)?.toDouble(),
      a2: (json['a2'] as num?)?.toDouble(),
      exameFinal: (json['exameFinal'] as num?)?.toDouble(),
      mediaSemestral: (json['mediaSemestral'] as num?)?.toDouble(),
      mediaFinal: (json['mediaFinal'] as num?)?.toDouble(),
      situacao: json['situacao'] ?? '',
      semestreAtual: json['semestreAtual'] ?? false,
    );
  }
}