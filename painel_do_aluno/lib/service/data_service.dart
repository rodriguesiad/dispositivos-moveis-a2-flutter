import 'package:painel_do_aluno/models/curso.dart';
import 'package:painel_do_aluno/models/disciplina.dart';

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
        faltas: 3,
        a1: 8.0,
        a2: 7.5,
        exameFinal: null,
        mediaSemestral: 7.75,
        mediaFinal: 7.75,
        situacao: 'APROVADO',
        cargaHoraria: 60,
        cursoId: '1',
      ),
      Disciplina(
        id: '2',
        nome: 'Matemática Discreta',
        faltas: 5,
        a1: 5.0,
        a2: 4.5,
        exameFinal: 7.0,
        mediaSemestral: 4.75,
        mediaFinal: 6.0,
        situacao: 'APROVADO',
        cargaHoraria: 60,
        cursoId: '1',
      ),
      Disciplina(
        id: '3',
        nome: 'Engenharia de Software',
        faltas: 7,
        a1: 3.0,
        a2: 2.5,
        exameFinal: null,
        mediaSemestral: 2.75,
        mediaFinal: 2.75,
        situacao: 'REPROVADO',
        cargaHoraria: 60,
        cursoId: '1',
      ),
      Disciplina(
        id: '4',
        nome: 'Banco de Dados',
        faltas: 2,
        a1: 7.0,
        a2: 0.0,
        exameFinal: null,
        mediaSemestral: 3.5,
        mediaFinal: 3.5,
        situacao: 'MATRICULADO',
        cargaHoraria: 60,
        cursoId: '1',
      ),

      // Disciplinas de Administração (ID = 2)
      Disciplina(
        id: '5',
        nome: 'Introdução à Administração',
        faltas: 2,
        a1: 7.0,
        a2: 8.0,
        exameFinal: null,
        mediaSemestral: 7.5,
        mediaFinal: 7.5,
        situacao: 'APROVADO',
        cargaHoraria: 60,
        cursoId: '2',
      ),
      Disciplina(
        id: '6',
        nome: 'Contabilidade Básica',
        faltas: 3,
        a1: 6.0,
        a2: 7.0,
        exameFinal: 6.5,
        mediaSemestral: 6.5,
        mediaFinal: 6.5,
        situacao: 'APROVADO',
        cargaHoraria: 60,
        cursoId: '2',
      ),
      Disciplina(
        id: '7',
        nome: 'Gestão de Pessoas',
        faltas: 1,
        a1: 8.0,
        a2: 8.5,
        exameFinal: null,
        mediaSemestral: 8.25,
        mediaFinal: 8.25,
        situacao: 'APROVADO',
        cargaHoraria: 60,
        cursoId: '2',
      ),
      Disciplina(
        id: '8',
        nome: 'Marketing',
        faltas: 4,
        a1: 5.5,
        a2: 6.0,
        exameFinal: 7.0,
        mediaSemestral: 5.75,
        mediaFinal: 6.5,
        situacao: 'MATRICULADO',
        cargaHoraria: 60,
        cursoId: '2',
      ),
    ];
  }
}