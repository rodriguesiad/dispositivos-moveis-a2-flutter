class Aluno {
  final String id;
  final String nome;
  final String email;
  final String cpf;
  final String senha;
  final String status;
  final String numeroMatricula;
  final bool simIdentidade;
  final bool simCertNascimento;
  final bool simHistoricoEscolar;
  final bool simDiploma;
  final bool simCompVacina;

  Aluno({
    required this.id,
    required this.nome,
    required this.email,
    required this.cpf,
    required this.senha,
    required this.status,
    required this.numeroMatricula,
    required this.simIdentidade,
    required this.simCertNascimento,
    required this.simHistoricoEscolar,
    required this.simDiploma,
    required this.simCompVacina,
  });

  factory Aluno.fromJson(Map<String, dynamic> json) {
    return Aluno(
      id: json['id'],
      nome: json['nome'],
      email: json['email'],
      cpf: json['cpf'],
      senha: json['senha'],
      status: json['status'],
      numeroMatricula: json['numeroMatricula'],
      simIdentidade: json['simIdentidade'],
      simCertNascimento: json['simCertNascimento'],
      simHistoricoEscolar: json['simHistoricoEscolar'],
      simDiploma: json['simDiploma'],
      simCompVacina: json['simCompVacina'],
    );
  }
}
