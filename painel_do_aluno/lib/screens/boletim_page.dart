import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/curso.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'package:painel_do_aluno/models/matricula.dart';
import 'package:painel_do_aluno/service/data_service.dart';
import 'package:painel_do_aluno/service/helpers/boletim_helper.dart';
import 'package:painel_do_aluno/widgets/boletim_card.dart';
import 'package:painel_do_aluno/widgets/curso_dropdown_widget.dart';
import 'package:painel_do_aluno/widgets/portal_app_header.dart';

class BoletimPage extends StatefulWidget {
  const BoletimPage({super.key});

  @override
  State<BoletimPage> createState() => _BoletimPageState();
}

class _BoletimPageState extends State<BoletimPage> {
  late Future<List<Curso>> cursosFuture;
  late Future<List<Disciplina>> disciplinasFuture;
  late Future<List<Matricula>> matriculasFuture;

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cabeçalho fixo com "Portal do Aluno"
          const PortalAppHeader(),
          Padding(
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
                        "Boletim Acadêmico",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[900],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Selecione um curso para visualizar as notas do semestre atual.",
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

                        final disciplinasFiltradas =
                            cursoSelecionado == null
                                ? []
                                : filtrarDisciplinasDoCursoAtivo(
                                  cursoSelecionado!,
                                  disciplinas!,
                                  matriculas!,
                                );

                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: CursoDropdownWidget(
                                cursos: cursos!,
                                cursoSelecionado: cursoSelecionado,
                                onChanged: (novo) {
                                  setState(() {
                                    cursoSelecionado = novo;
                                  });
                                },
                              ),
                            ),

                            if (cursoSelecionado != null)
                              Expanded(
                                child: ListView(
                                  children:
                                      disciplinasFiltradas.map((disciplina) {
                                        final matricula = matriculas!
                                            .firstWhereOrNull(
                                              (m) =>
                                                  m.disciplinaId ==
                                                      disciplina.id &&
                                                  m.semestreAtual,
                                            );
                                        return BoletimCard(
                                          disciplina: disciplina,
                                          matricula: matricula,
                                        );
                                      }).toList(),
                                ),
                              ),
                            if (cursoSelecionado == null)
                              const Expanded(
                                child: Center(
                                  child: Text(
                                    'Por favor, selecione um curso acima para visualizar o boletim.',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
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
          ),
        ],
      ),
    );
  }
}
