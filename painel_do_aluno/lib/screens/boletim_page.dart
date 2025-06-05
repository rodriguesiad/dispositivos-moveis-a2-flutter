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
  late List<Curso> cursos;
  late List<Disciplina> disciplinas;
  late List<MatriculaDisciplina> matriculas;
  String? cursoSelecionado;
  final DataService dataService = DataService();

  @override
  void initState() {
    super.initState();
    cursos = dataService.carregarCursos();
    disciplinas = dataService.carregarDisciplinas();
    matriculas = dataService.carregarMatriculas(); // Carrega as matrículas
  }

  @override
  Widget build(BuildContext context) {
    // Filtra as disciplinas com base no curso selecionado e semestre atual
    final disciplinasFiltradas = cursoSelecionado == null
        ? []
        : disciplinas.where((disciplina) {
            // Verifica se a disciplina pertence ao curso selecionado e se o aluno está matriculado no semestre atual
            final matriculaExiste = matriculas.any(
              (matricula) =>
                  matricula.disciplinaId == disciplina.id &&
                  matricula.semestreAtual,
            );
            return matriculaExiste && disciplina.cursoId == cursoSelecionado;
          }).toList();

    // Definindo o título e o subtítulo
    final subtitle = cursoSelecionado == null
        ? ""
        : cursos.firstWhere((c) => c.id == cursoSelecionado).nome;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Boletim Acadêmico", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 2),
            Text(
              subtitle,  // Agora não está em um widget const
              style: const TextStyle(
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
          // Verifica se o curso foi selecionado antes de exibir as disciplinas
          if (cursoSelecionado != null)
            Expanded(
              child: ListView(
                children: disciplinasFiltradas
                    .map<Widget>((disciplina) => _buildCard(disciplina))
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
      ),
    );
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text("Carga Horária: ${d.cargaHoraria}h"),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1),
      ],
    );
  }
}
