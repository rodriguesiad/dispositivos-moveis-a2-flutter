import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/aluno.dart';
import 'package:painel_do_aluno/models/curso.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'package:painel_do_aluno/models/matricula.dart';
import 'package:painel_do_aluno/service/data_service.dart';
import 'package:painel_do_aluno/widgets/curso_dropdown_widget.dart';
import 'package:painel_do_aluno/widgets/lista_disciplinas_selecionaveis.dart';
import 'package:painel_do_aluno/widgets/portal_app_header.dart';

class RematriculaPage extends StatefulWidget {
  final Aluno aluno;
  const RematriculaPage({super.key, required this.aluno});

  @override
  State<RematriculaPage> createState() => _RematriculaPageState();
}

class _RematriculaPageState extends State<RematriculaPage> {
  late Future<List<Curso>> cursosFuture;
  late Future<List<Disciplina>> disciplinasFuture;
  late Future<List<Matricula>> matriculasFuture;

  String? cursoSelecionado;
  List<Disciplina> disciplinasSelecionadas = [];

  final DataService dataService = DataService();

  @override
  void initState() {
    super.initState();
    cursosFuture = dataService.carregarCursos();
    disciplinasFuture = dataService.carregarDisciplinas();
    matriculasFuture = dataService.carregarMatriculasDoAluno(widget.aluno.id);
  }

  List<Disciplina> _filtrarDisciplinas({
    required String cursoId,
    required List<Disciplina> disciplinas,
    required List<Matricula> matriculas,
  }) {
    return disciplinas.where((disciplina) {
      if (disciplina.cursoId != cursoId) return false;

      final matriculaSemestreAtual = matriculas.any(
        (matricula) =>
            matricula.disciplinaId == disciplina.id && matricula.semestreAtual,
      );

      final matriculaAprovadaAnterior = matriculas.any(
        (matricula) =>
            matricula.disciplinaId == disciplina.id &&
            !matricula.semestreAtual &&
            matricula.situacao == 'APROVADO',
      );

      return !matriculaSemestreAtual && !matriculaAprovadaAnterior;
    }).toList();
  }

  Future<void> _confirmarMatricula() async {
    try {
      for (var disciplina in disciplinasSelecionadas) {
        final matricula = Matricula(
          id: UniqueKey().toString(),
          disciplinaId: disciplina.id,
          faltas: 0,
          a1: null,
          a2: null,
          exameFinal: null,
          mediaSemestral: null,
          mediaFinal: null,
          alunoId: widget.aluno.id,
          semestreAtual: true,
          situacao: 'MATRICULADO',
        );

        await dataService.salvarMatricula(matricula);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Matrícula confirmada com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );

      await Future.delayed(const Duration(seconds: 2));
      Navigator.pushNamed(context, '/home', arguments: widget.aluno);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao confirmar matrícula: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PortalAppHeader(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BackButton(),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Rematrícula",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[900],
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Selecione um curso para visualizar as disciplinas disponíveis.",
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
                  return const Center(child: Text('Erro ao carregar cursos'));
                }
                final cursos = snapshotCursos.data!;

                return FutureBuilder<List<Disciplina>>(
                  future: disciplinasFuture,
                  builder: (context, snapshotDisciplinas) {
                    if (snapshotDisciplinas.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshotDisciplinas.hasError) {
                      return const Center(
                        child: Text('Erro ao carregar disciplinas'),
                      );
                    }
                    final disciplinas = snapshotDisciplinas.data!;

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
                          return const Center(
                            child: Text('Erro ao carregar matrículas'),
                          );
                        }
                        final matriculas = snapshotMatriculas.data!;

                        final disciplinasDisponiveis =
                            cursoSelecionado == null
                                ? <Disciplina>[]
                                : _filtrarDisciplinas(
                                  cursoId: cursoSelecionado!,
                                  disciplinas: disciplinas,
                                  matriculas: matriculas,
                                );

                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              CursoDropdownWidget(
                                cursos: cursos,
                                cursoSelecionado: cursoSelecionado,
                                onChanged: (novo) {
                                  setState(() {
                                    cursoSelecionado = novo;
                                    disciplinasSelecionadas.clear();
                                  });
                                },
                              ),
                              const SizedBox(height: 20),
                              if (cursoSelecionado != null)
                                Expanded(
                                  child: ListaDisciplinasSelecionaveis(
                                    disciplinasDisponiveis:
                                        disciplinasDisponiveis,
                                    disciplinasSelecionadas:
                                        disciplinasSelecionadas,
                                    onSelecionar: (disciplina, selecionada) {
                                      setState(() {
                                        if (selecionada) {
                                          disciplinasSelecionadas.add(
                                            disciplina,
                                          );
                                        } else {
                                          disciplinasSelecionadas.remove(
                                            disciplina,
                                          );
                                        }
                                      });
                                    },
                                  ),
                                ),
                              if (cursoSelecionado == null)
                                const Expanded(
                                  child: Center(
                                    child: Text(
                                      'Selecione um curso para ver as disciplinas disponíveis.',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ElevatedButton(
                                onPressed:
                                    disciplinasSelecionadas.isNotEmpty
                                        ? () async {
                                          await _confirmarMatricula();
                                        }
                                        : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.indigo[900],
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 24,
                                  ),
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Text("CONFIRMAR MATRÍCULA"),
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
