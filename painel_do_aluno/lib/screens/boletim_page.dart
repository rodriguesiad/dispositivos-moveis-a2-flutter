import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/curso.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'package:painel_do_aluno/service/data_service.dart';

class BoletimPage extends StatefulWidget {
  const BoletimPage({super.key});

  @override
  State<BoletimPage> createState() => _BoletimPageState();
}

class _BoletimPageState extends State<BoletimPage> {
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
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text("Faltas: ${d.faltas}"),
              Text(
                "A1: ${d.a1.toStringAsFixed(1)}  |  A2: ${d.a2.toStringAsFixed(1)}",
              ),
              Text("Exame Final: ${d.exameFinal?.toStringAsFixed(1) ?? '--'}"),
              Text("Média Semestral: ${d.mediaSemestral.toStringAsFixed(1)}"),
              Text("Média Final: ${d.mediaFinal?.toStringAsFixed(1) ?? '--'}"),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text("Situação: "),
                  Text(
                    d.situacao,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color:
                          d.situacao == 'APROVADO'
                              ? Colors.green
                              : d.situacao == 'REPROVADO'
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

  @override
  Widget build(BuildContext context) {
    // Filtra as disciplinas com base no curso selecionado
    final disciplinasFiltradas = cursoSelecionado == null
        ? []
        : disciplinas
            .where((disciplina) => disciplina.cursoId == cursoSelecionado)
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Boletim Acadêmico", style: TextStyle(fontSize: 20)),
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

          if (cursoSelecionado != null)
            Expanded(
              child: ListView(
                children: disciplinasFiltradas.map<Widget>((disciplina) => _buildCard(disciplina)).toList(),
              ),
            ),

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
}
