import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/curso.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'package:painel_do_aluno/models/matricula_disciplina.dart';
import 'package:painel_do_aluno/service/data_service.dart';

class AnaliseCurricularPage extends StatefulWidget {
  const AnaliseCurricularPage({super.key});

  @override
  State<AnaliseCurricularPage> createState() => _AnaliseCurricularPageState();
}

class _AnaliseCurricularPageState extends State<AnaliseCurricularPage> {
  late List<Curso> cursos;
  late List<Disciplina> disciplinas;
  late List<MatriculaDisciplina> matriculas;
  String? cursoSelecionado;
  List<Disciplina> disciplinasConcluidas = [];
  List<Disciplina> disciplinasPendentes = [];
  double progressoCurso = 0.0;

  final DataService dataService = DataService();

  @override
  void initState() {
    super.initState();
    cursos = dataService.carregarCursos();
    disciplinas = dataService.carregarDisciplinas();
    matriculas = dataService.carregarMatriculas(); // Carrega as matrículas
  }

  // Função para calcular progresso do curso
  void _calcularProgresso() {
    if (cursoSelecionado == null) return;

    setState(() {
      // Filtra disciplinas do curso selecionado
      var disciplinasDoCurso = disciplinas.where((disciplina) {
        return disciplina.cursoId == cursoSelecionado;
      }).toList();

      // Filtra as disciplinas concluídas e pendentes
      disciplinasConcluidas = matriculas
          .where((matricula) =>
              matricula.situacao == 'APROVADO' &&
              disciplinasDoCurso.any((disciplina) =>
                  disciplina.id == matricula.disciplinaId))
          .map((matricula) =>
              disciplinas.firstWhere((disciplina) =>
                  disciplina.id == matricula.disciplinaId))
          .toList();

      disciplinasPendentes = disciplinasDoCurso
          .where((disciplina) =>
              !disciplinasConcluidas.contains(disciplina))
          .toList();

      // Calcula o progresso
      progressoCurso = (disciplinasConcluidas.length /
              disciplinasDoCurso.length) *
          100;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Atualiza o progresso do curso sempre que o curso for alterado
    _calcularProgresso();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Análise Curricular"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown para selecionar o curso
            DropdownButtonFormField<String>(
              value: cursoSelecionado,
              items: cursos.map((curso) {
                return DropdownMenuItem(
                  value: curso.id,
                  child: Text(curso.nome),
                );
              }).toList(),
              onChanged: (novo) {
                setState(() {
                  cursoSelecionado = novo;
                });
              },
              decoration: const InputDecoration(
                labelText: "Curso",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Barra de progresso do curso
            if (cursoSelecionado != null)
              Column(
                children: [
                  Text(
                    "Progresso do Curso: ${progressoCurso.toStringAsFixed(1)}%",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  LinearProgressIndicator(
                    value: progressoCurso / 100,
                    minHeight: 8,
                    backgroundColor: Colors.grey[300],
                    color: Colors.green,
                  ),
                ],
              ),
            const SizedBox(height: 20),

            // Disciplinas Concluídas
            if (disciplinasConcluidas.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Disciplinas Concluídas:",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  ...disciplinasConcluidas.map((disciplina) {
                    return ListTile(
                      title: Text(disciplina.nome),
                      subtitle: Text("Carga Horária: ${disciplina.cargaHoraria}h"),
                    );
                  }).toList(),
                ],
              ),
            const SizedBox(height: 20),

            // Disciplinas Pendentes
            if (disciplinasPendentes.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Disciplinas Pendentes:",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  ...disciplinasPendentes.map((disciplina) {
                    return ListTile(
                      title: Text(disciplina.nome),
                      subtitle: Text("Carga Horária: ${disciplina.cargaHoraria}h"),
                    );
                  }).toList(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}