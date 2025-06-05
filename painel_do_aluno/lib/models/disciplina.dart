class Disciplina {
  final String id;
  final String nome;
  final int faltas;
  final double a1;
  final double a2;
  final double? exameFinal;
  final double mediaSemestral;
  final double? mediaFinal;
  final String situacao;
  final int cargaHoraria;
  final String cursoId; 

  Disciplina({
    required this.id,
    required this.nome,
    required this.faltas,
    required this.a1,
    required this.a2,
    this.exameFinal,
    required this.mediaSemestral,
    this.mediaFinal,
    required this.situacao,
    required this.cargaHoraria,
    required this.cursoId, 
  });
}
