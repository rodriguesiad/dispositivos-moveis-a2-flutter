import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:painel_do_aluno/models/curso.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'package:painel_do_aluno/models/matricula.dart';
import 'package:painel_do_aluno/models/aluno.dart';

class DataService {
  final String baseUrl = 'http://localhost:3000';

  Future<List<Curso>> carregarCursos() async {
    final response = await http.get(Uri.parse('$baseUrl/cursos'));

    if (response.statusCode == 200) {
      final List<dynamic> cursosJson = json.decode(
        utf8.decode(response.bodyBytes),
      );
      return cursosJson.map((json) => Curso.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar cursos');
    }
  }

  Future<List<Disciplina>> carregarDisciplinas() async {
    final response = await http.get(Uri.parse('$baseUrl/disciplinas'));

    if (response.statusCode == 200) {
      final List<dynamic> disciplinasJson = json.decode(
        utf8.decode(response.bodyBytes),
      );
      return disciplinasJson.map((json) => Disciplina.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar disciplinas');
    }
  }

  Future<List<Matricula>> carregarMatriculas() async {
    final response = await http.get(Uri.parse('$baseUrl/matriculas'));

    if (response.statusCode == 200) {
      final List<dynamic> matriculasJson = json.decode(
        utf8.decode(response.bodyBytes),
      );
      return matriculasJson.map((json) => Matricula.fromJson(json)).toList();
    } else {
      throw Exception('Erro ao carregar matriculas');
    }
  }

  Future<Aluno> carregarAluno() async {
    final response = await http.get(Uri.parse('$baseUrl/alunos/1'));

    if (response.statusCode == 200) {
      final alunoJson = json.decode(utf8.decode(response.bodyBytes));
      return Aluno.fromJson(alunoJson);
    } else {
      throw Exception('Erro ao carregar aluno');
    }
  }

  Future<void> salvarMatricula(Matricula matricula) async {
    final url = Uri.parse('$baseUrl/matriculas');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(matricula.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Erro ao cadastrar matrícula: ${response.body}');
    }
  }

  Future<Aluno> carregarAlunoPorEmail(String email) async {
    final url = Uri.parse('$baseUrl/alunos?email=$email');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dados = jsonDecode(response.body);
      return Aluno.fromJson(dados[0]); 
    } else {
      throw Exception('Erro ao carregar aluno');
    }
  }
}
