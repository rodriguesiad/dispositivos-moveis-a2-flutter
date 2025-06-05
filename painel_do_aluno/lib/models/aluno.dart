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
}
