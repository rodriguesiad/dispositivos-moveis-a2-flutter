import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'package:painel_do_aluno/models/curso.dart';
import 'package:painel_do_aluno/service/data_service.dart';

class GradeCurricularPage extends StatefulWidget {
  const GradeCurricularPage({super.key});

  @override
  State<GradeCurricularPage> createState() => _GradeCurricularPageState();
}

class _GradeCurricularPageState extends State<GradeCurricularPage> {
  late Future<List<Curso>> cursosFuture;
  late Future<List<Disciplina>> disciplinasFuture;

  String? cursoSelecionado;
  final DataService dataService = DataService();

  @override
  void initState() {
    super.initState();
    cursosFuture = dataService.carregarCursos();
    disciplinasFuture = dataService.carregarDisciplinas();
  }

  // Agrupamento por período com base nas disciplinas do curso
  Map<String, List<Disciplina>> _agruparDisciplinasPorPeriodo(
      List<Disciplina> disciplinas) {
    Map<String, List<Disciplina>> agrupamento = {};

    var disciplinasFiltradas = cursoSelecionado == null
        ? []
        : disciplinas
            .where((disciplina) => disciplina.cursoId == cursoSelecionado)
            .toList();

    for (var disciplina in disciplinasFiltradas) {
      agrupamento.putIfAbsent(disciplina.periodo, () => []).add(disciplina);
    }

    return agrupamento;
  }

  Widget _buildCard(Disciplina d) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            d.nome,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Text("Carga Horária: ${d.cargaHoraria}h"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Matriz Curricular"),
      ),
      body: FutureBuilder<List<Curso>>(
        future: cursosFuture,
        builder: (context, snapshotCursos) {
          if (snapshotCursos.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshotCursos.hasError) {
            return Center(child: Text('Erro ao carregar cursos'));
          }

          final cursos = snapshotCursos.data!;

          return FutureBuilder<List<Disciplina>>(
            future: disciplinasFuture,
            builder: (context, snapshotDisciplinas) {
              if (snapshotDisciplinas.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshotDisciplinas.hasError) {
                return Center(child: Text('Erro ao carregar disciplinas'));
              }

              final disciplinas = snapshotDisciplinas.data!;
              final disciplinasPorPeriodo = _agruparDisciplinasPorPeriodo(disciplinas);

              final subtitle = cursoSelecionado == null
                  ? "Selecione um curso"
                  : cursos.firstWhere((c) => c.id == cursoSelecionado).nome;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: DropdownButtonFormField<String>(
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
                  ),
                  Text(subtitle),
                  const SizedBox(height: 10),

                  if (cursoSelecionado != null)
                    Expanded(
                      child: ListView(
                        children: disciplinasPorPeriodo.keys.map<Widget>((periodo) {
                          var disciplinasDoPeriodo = disciplinasPorPeriodo[periodo]!;
                          return ExpansionTile(
                            title: Text("Período $periodo"),
                            children: disciplinasDoPeriodo
                                .map<Widget>((d) => _buildCard(d))
                                .toList(),
                          );
                        }).toList(),
                      ),
                    ),
                  if (cursoSelecionado == null)
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Por favor, selecione um curso acima para visualizar a matriz curricular.',
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
      ),
    );
  }
}
