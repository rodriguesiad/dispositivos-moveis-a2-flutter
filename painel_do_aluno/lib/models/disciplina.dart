class Disciplina {
  final String id;
  final String nome;
  final int cargaHoraria;
  final String cursoId; 
  final String periodo;

  Disciplina({
    required this.id,
    required this.nome,
    required this.cargaHoraria,
    required this.cursoId, 
    required this.periodo
  });

  factory Disciplina.fromJson(Map<String, dynamic> json) {
    return Disciplina(
      id: json['id'],
      nome: json['nome'],
      cargaHoraria: json['cargaHoraria'],
      cursoId: json['cursoId'],
      periodo: json['periodo'],
    );
  }
}
