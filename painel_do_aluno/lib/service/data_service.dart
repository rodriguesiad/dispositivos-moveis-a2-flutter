import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:painel_do_aluno/models/curso.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'package:painel_do_aluno/models/matricula_disciplina.dart';
import 'package:painel_do_aluno/models/aluno.dart';

class DataService {
  final String baseUrl = 'http://localhost:3000'; 

  Future<List<Curso>> carregarCursos() async {
    final response = await http.get(Uri.parse('$baseUrl/cursos'));

    if (response.statusCode == 200) {
      final List<dynamic> cursosJson = json.decode(response.body);
      return cursosJson.map((json) => Curso.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar cursos');
    }
  }

  Future<List<Disciplina>> carregarDisciplinas() async {
    final response = await http.get(Uri.parse('$baseUrl/disciplinas'));

    if (response.statusCode == 200) {
      final List<dynamic> disciplinasJson = json.decode(response.body);
      return disciplinasJson.map((json) => Disciplina.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar disciplinas');
    }
  }

  Future<List<MatriculaDisciplina>> carregarMatriculas() async {
    final response = await http.get(Uri.parse('$baseUrl/matriculas'));

    if (response.statusCode == 200) {
      final List<dynamic> matriculasJson = json.decode(response.body);
      return matriculasJson.map((json) => MatriculaDisciplina.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar matriculas');
    }
  }

  Future<Aluno> carregarAluno() async {
    final response = await http.get(Uri.parse('$baseUrl/alunos/1'));

    if (response.statusCode == 200) {
      final alunoJson = json.decode(response.body);
      return Aluno.fromJson(alunoJson);
    } else {
      throw Exception('Erro ao carregar aluno');
    }
  }
}
