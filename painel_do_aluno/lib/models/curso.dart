class Curso {
  final String id;
  final String nome;

  Curso({required this.id, required this.nome});

  factory Curso.fromJson(Map<String, dynamic> json) {
    return Curso(
      id: json['id'],
      nome: json['nome'],
    );
  }
}