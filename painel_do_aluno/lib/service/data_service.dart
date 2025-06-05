import 'package:painel_do_aluno/models/curso.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'package:painel_do_aluno/models/matricula_disciplina.dart';
import 'package:painel_do_aluno/models/aluno.dart';

class DataService {
  // Método que retorna a lista de cursos
  List<Curso> carregarCursos() {
    return [
      Curso(id: '1', nome: "Sistemas de Informação"),
      Curso(id: '2', nome: "Administração"),
    ];
  }

  // Método que retorna a lista de disciplinas
  List<Disciplina> carregarDisciplinas() {
    return [
      // Disciplinas de Sistemas de Informação (ID = 1)
      Disciplina(
        id: '1',
        nome: 'Algoritmos',
        cargaHoraria: 60,
        cursoId: '1',
        periodo: '1',
      ),
      Disciplina(
        id: '2',
        nome: 'Matemática Discreta',
        cargaHoraria: 60,
        cursoId: '1',
        periodo: '1',
      ),
      Disciplina(
        id: '3',
        nome: 'Engenharia de Software',
        cargaHoraria: 60,
        cursoId: '1',
        periodo: '2',
      ),
      Disciplina(
        id: '4',
        nome: 'Banco de Dados',
        cargaHoraria: 60,
        cursoId: '1',
        periodo: '2',
      ),

      // Disciplinas de Administração (ID = 2)
      Disciplina(
        id: '5',
        nome: 'Introdução à Administração',
        cargaHoraria: 60,
        cursoId: '2',
        periodo: '1',
      ),
      Disciplina(
        id: '6',
        nome: 'Contabilidade Básica',
        cargaHoraria: 60,
        cursoId: '2',
        periodo: '1',
      ),
      Disciplina(
        id: '7',
        nome: 'Gestão de Pessoas',
        cargaHoraria: 60,
        cursoId: '2',
        periodo: '2',
      ),
      Disciplina(
        id: '8',
        nome: 'Marketing',
        cargaHoraria: 60,
        cursoId: '2',
        periodo: '2',
      ),
    ];
  }

  // Método que retorna a lista de matrícula de disciplinas (matriculas dos alunos nas disciplinas)
    List<MatriculaDisciplina> carregarMatriculas() {
    return [
      MatriculaDisciplina(
        id: '1',
        disciplinaId: '1',
        alunoId: '1',
        faltas: 3,
        a1: 8.0,
        a2: 7.5,
        exameFinal: null,
        mediaSemestral: 7.75,
        mediaFinal: 7.75,
        situacao: 'APROVADO',
        semestreAtual: true,  // Indica que esta matrícula é do semestre atual
      ),
      MatriculaDisciplina(
        id: '2',
        disciplinaId: '2',
        alunoId: '1',
        faltas: 5,
        a1: 5.0,
        a2: 4.5,
        exameFinal: 7.0,
        mediaSemestral: 4.75,
        mediaFinal: 6.0,
        situacao: 'APROVADO',
        semestreAtual: true,  // Indica que esta matrícula é do semestre atual
      ),
      MatriculaDisciplina(
        id: '3',
        disciplinaId: '5',
        alunoId: '2',
        faltas: 2,
        a1: 7.0,
        a2: 8.0,
        exameFinal: null,
        mediaSemestral: 7.5,
        mediaFinal: 7.5,
        situacao: 'APROVADO',
        semestreAtual: true,  // Indica que esta matrícula é do semestre atual
      ),
      MatriculaDisciplina(
        id: '4',
        disciplinaId: '6',
        alunoId: '2',
        faltas: 3,
        a1: 6.0,
        a2: 7.0,
        exameFinal: 6.5,
        mediaSemestral: 6.5,
        mediaFinal: 6.5,
        situacao: 'APROVADO',
        semestreAtual: false, // Esta matrícula não é do semestre atual
      ),
    ];
  }


  // Método que retorna um aluno fictício
  Aluno carregarAluno() {
    return Aluno(
      id: '1',
      nome: 'João Silva',
      email: 'joao.silva@email.com',
      cpf: '12345678901',
      senha: 'senha123',
      status: 'Ativo',
      numeroMatricula: '12345',
      simIdentidade: true,
      simCertNascimento: true,
      simHistoricoEscolar: true,
      simDiploma: false,
      simCompVacina: true,
    );
  }
}
