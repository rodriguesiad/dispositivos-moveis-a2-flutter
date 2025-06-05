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
  late List<Curso> cursos;
  late List<Disciplina> disciplinas;
  String? cursoSelecionado;
  final DataService dataService = DataService();

  @override
  void initState() {
    super.initState();
    cursos = dataService.carregarCursos();
    disciplinas = dataService.carregarDisciplinas();
  }

  Widget _buildCard(Disciplina d) {
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
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              Text("Carga Horária: ${d.cargaHoraria}h"),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Verifica se o curso foi selecionado antes de mostrar as disciplinas
    final disciplinasFiltradas =
        cursoSelecionado == null
            ? []
            : disciplinas
                .where((disciplina) => disciplina.cursoId == cursoSelecionado)
                .toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Matriz Curricular", style: TextStyle(fontSize: 20)),
            SizedBox(height: 2),
            Text(
              "Selecione o curso abaixo",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(179, 65, 65, 65),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<String>(
              value: cursoSelecionado,
              items:
                  cursos.map((curso) {
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
                children:
                    disciplinasFiltradas
                        .map<Widget>((disciplina) => _buildCard(disciplina))
                        .toList(),
              ),
            ),
          // Caso não tenha um curso selecionado, exibe uma mensagem
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
      ),
    );
  }
}
