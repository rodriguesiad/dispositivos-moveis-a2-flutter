import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/curso.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'package:painel_do_aluno/models/matricula.dart';
import 'package:painel_do_aluno/service/data_service.dart';
import 'package:painel_do_aluno/widgets/progresso_curso_widget.dart';
import 'package:painel_do_aluno/widgets/lista_disciplinas_widget.dart';
import 'package:painel_do_aluno/widgets/curso_dropdown_widget.dart';
import 'package:painel_do_aluno/widgets/portal_app_header.dart';

class AnaliseCurricularPage extends StatefulWidget {
  const AnaliseCurricularPage({super.key});

  @override
  State<AnaliseCurricularPage> createState() => _AnaliseCurricularPageState();
}

class _AnaliseCurricularPageState extends State<AnaliseCurricularPage> {
  late Future<List<Curso>> cursosFuture;
  late Future<List<Disciplina>> disciplinasFuture;
  late Future<List<Matricula>> matriculasFuture;
  String? cursoSelecionado;
  double progressoCurso = 0.0;
  List<Disciplina> disciplinasConcluidas = [];
  List<Disciplina> disciplinasPendentes = [];

  final DataService dataService = DataService();

  @override
  void initState() {
    super.initState();
    cursosFuture = dataService.carregarCursos();
    disciplinasFuture = dataService.carregarDisciplinas();
    matriculasFuture = dataService.carregarMatriculas();
  }

  // Função para calcular progresso do curso
  void _calcularProgresso(
    List<Disciplina> disciplinasDoCurso,
    List<Matricula> matriculas,
  ) {
    setState(() {
      // Filtra as disciplinas concluídas e pendentes
      disciplinasConcluidas =
          matriculas
              .where(
                (matricula) =>
                    matricula.situacao == 'APROVADO' &&
                    disciplinasDoCurso.any(
                      (disciplina) => disciplina.id == matricula.disciplinaId,
                    ),
              )
              .map(
                (matricula) => disciplinasDoCurso.firstWhere(
                  (disciplina) => disciplina.id == matricula.disciplinaId,
                ),
              )
              .toList();

      disciplinasPendentes =
          disciplinasDoCurso
              .where(
                (disciplina) => !disciplinasConcluidas.contains(disciplina),
              )
              .toList();

      // Calcula o progresso
      progressoCurso =
          (disciplinasConcluidas.length / disciplinasDoCurso.length) * 100;
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PortalAppHeader(),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BackButton(),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Análise Curricular",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Veja o progresso e disciplinas concluídas e pendentes.",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder<List<Curso>>(
              future: cursosFuture,
              builder: (context, snapshotCursos) {
                if (snapshotCursos.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshotCursos.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar cursos: ${snapshotCursos.error}',
                    ),
                  );
                }

                final cursos = snapshotCursos.data;

                return FutureBuilder<List<Disciplina>>(
                  future: disciplinasFuture,
                  builder: (context, snapshotDisciplinas) {
                    if (snapshotDisciplinas.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshotDisciplinas.hasError) {
                      return Center(
                        child: Text(
                          'Erro ao carregar disciplinas: ${snapshotDisciplinas.error}',
                        ),
                      );
                    }

                    final disciplinas = snapshotDisciplinas.data;

                    return FutureBuilder<List<Matricula>>(
                      future: matriculasFuture,
                      builder: (context, snapshotMatriculas) {
                        if (snapshotMatriculas.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshotMatriculas.hasError) {
                          return Center(
                            child: Text(
                              'Erro ao carregar matrículas: ${snapshotMatriculas.error}',
                            ),
                          );
                        }

                        final matriculas = snapshotMatriculas.data;

                        final List<Disciplina> disciplinasDoCurso =
                            cursoSelecionado == null
                                ? <Disciplina>[]
                                : disciplinas!
                                    .where(
                                      (disciplina) =>
                                          disciplina.cursoId ==
                                          cursoSelecionado,
                                    )
                                    .toList();

                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) {
                            _calcularProgresso(disciplinasDoCurso, matriculas!);
                          }
                        });

                        return SingleChildScrollView(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CursoDropdownWidget(
                                cursos: cursos!,
                                cursoSelecionado: cursoSelecionado,
                                onChanged: (novo) {
                                  setState(() {
                                    cursoSelecionado = novo;
                                  });
                                },
                              ),
                              const SizedBox(height: 20),

                              if (cursoSelecionado != null)
                                ProgressoCursoWidget(progresso: progressoCurso),
                              const SizedBox(height: 20),

                              if (disciplinasConcluidas.isNotEmpty)
                                ListaDisciplinasWidget(
                                  titulo: "Disciplinas Concluídas:",
                                  disciplinas: disciplinasConcluidas,
                                ),
                              const SizedBox(height: 20),

                              if (disciplinasPendentes.isNotEmpty)
                                ListaDisciplinasWidget(
                                  titulo: "Disciplinas Pendentes:",
                                  disciplinas: disciplinasPendentes,
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
