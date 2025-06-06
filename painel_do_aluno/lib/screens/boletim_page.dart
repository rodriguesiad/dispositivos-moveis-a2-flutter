import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/curso.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'package:painel_do_aluno/models/matricula_disciplina.dart';
import 'package:painel_do_aluno/service/data_service.dart';

class BoletimPage extends StatefulWidget {
  const BoletimPage({super.key});

  @override
  State<BoletimPage> createState() => _BoletimPageState();
}

class _BoletimPageState extends State<BoletimPage> {
  late Future<List<Curso>> cursosFuture;
  late Future<List<Disciplina>> disciplinasFuture;
  late Future<List<MatriculaDisciplina>> matriculasFuture;
  String? cursoSelecionado;
  final DataService dataService = DataService();

  @override
  void initState() {
    super.initState();
    cursosFuture = dataService.carregarCursos();
    disciplinasFuture = dataService.carregarDisciplinas();
    matriculasFuture = dataService.carregarMatriculas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Boletim Acadêmico"),
      ),
      body: FutureBuilder<List<Curso>>(
        future: cursosFuture,
        builder: (context, snapshotCursos) {
          if (snapshotCursos.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshotCursos.hasError) {
            return Center(child: Text('Erro ao carregar cursos: ${snapshotCursos.error}'));
          }

          final cursos = snapshotCursos.data;

          return FutureBuilder<List<Disciplina>>(
            future: disciplinasFuture,
            builder: (context, snapshotDisciplinas) {
              if (snapshotDisciplinas.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshotDisciplinas.hasError) {
                return Center(child: Text('Erro ao carregar disciplinas: ${snapshotDisciplinas.error}'));
              }

              final disciplinas = snapshotDisciplinas.data;

              return FutureBuilder<List<MatriculaDisciplina>>(
                future: matriculasFuture,
                builder: (context, snapshotMatriculas) {
                  if (snapshotMatriculas.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshotMatriculas.hasError) {
                    return Center(child: Text('Erro ao carregar matrículas: ${snapshotMatriculas.error}'));
                  }

                  final matriculas = snapshotMatriculas.data;

                  // Filtra as disciplinas com base no curso selecionado e semestre atual
                  final disciplinasFiltradas = cursoSelecionado == null
                      ? []
                      : disciplinas!.where((disciplina) {
                          final matriculaExiste = matriculas!.any(
                            (matricula) =>
                                matricula.disciplinaId == disciplina.id &&
                                matricula.semestreAtual,
                          );
                          return matriculaExiste && disciplina.cursoId == cursoSelecionado;
                        }).toList();

                  // Definindo o título e o subtítulo
                  final subtitle = cursoSelecionado == null
                      ? ""
                      : cursos!.firstWhere((c) => c.id == cursoSelecionado).nome;

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: DropdownButtonFormField<String>(
                          value: cursoSelecionado,
                          items: cursos!.map((curso) {
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
                      ),

                      // Verifica se o curso foi selecionado antes de exibir as disciplinas
                      if (cursoSelecionado != null)
                        Expanded(
                          child: ListView(
                            children: disciplinasFiltradas
                                .map<Widget>((disciplina) => _buildCard(disciplina, matriculas))
                                .toList(),
                          ),
                        ),

                      // Caso não tenha um curso selecionado, exibe uma mensagem
                      if (cursoSelecionado == null)
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Por favor, selecione um curso acima para visualizar o boletim.',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  // Função para exibir as informações detalhadas de cada disciplina
  Widget _buildCard(Disciplina d, List<MatriculaDisciplina>? matriculas) {
    // Encontra a matrícula da disciplina no semestre atual
    final matricula = matriculas!.firstWhere(
      (m) => m.disciplinaId == d.id && m.semestreAtual,
      orElse: () => MatriculaDisciplina(
        id: '',
        disciplinaId: '',
        alunoId: '',
        faltas: 0,
        a1: 0.0,
        a2: 0.0,
        exameFinal: 0.0,
        mediaSemestral: 0.0,
        situacao: 'NÃO MATRICULADO',
        semestreAtual: false,
      ),
    );

    return Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                d.nome,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text("Faltas: ${matricula.faltas}"),
              Text("A1: ${matricula.a1.toStringAsFixed(1)}"),
              Text("A2: ${matricula.a2.toStringAsFixed(1)}"),
              Text(
                "Exame Final: ${matricula.exameFinal?.toStringAsFixed(1) ?? '--'}",
              ),
              Text("Média Final: ${matricula.mediaSemestral.toStringAsFixed(1)}"),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text("Situação: "),
                  Text(
                    matricula.situacao,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: matricula.situacao == 'APROVADO'
                          ? Colors.green
                          : matricula.situacao == 'REPROVADO'
                              ? Colors.red
                              : Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
