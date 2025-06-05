import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/curso.dart';
import 'package:painel_do_aluno/models/disciplina.dart';
import 'package:painel_do_aluno/models/matricula_disciplina.dart';
import 'package:painel_do_aluno/service/data_service.dart';

class RematriculaPage extends StatefulWidget {
  const RematriculaPage({super.key});

  @override
  State<RematriculaPage> createState() => _RematriculaPageState();
}

class _RematriculaPageState extends State<RematriculaPage> {
  late List<Curso> cursos;
  late List<Disciplina> disciplinas;
  late List<MatriculaDisciplina> matriculas;
  String? cursoSelecionado;
  List<Disciplina> disciplinasDisponiveis = [];
  final DataService dataService = DataService();
  List<Disciplina> disciplinasSelecionadas = [];

  @override
  void initState() {
    super.initState();
    cursos = dataService.carregarCursos();
    disciplinas = dataService.carregarDisciplinas();
    matriculas = dataService.carregarMatriculas(); // Carrega as matrículas
  }

  // Função para filtrar disciplinas disponíveis para matrícula
  void _filtrarDisciplinas() {
    if (cursoSelecionado == null) return;

    setState(() {
      // Filtra as disciplinas do curso selecionado
      disciplinasDisponiveis = disciplinas.where((disciplina) {
        // Verifica se a disciplina pertence ao curso selecionado
        if (disciplina.cursoId != cursoSelecionado) return false;

        // Verifica se o aluno já está matriculado ou aprovado
        final matriculaExiste = matriculas.any(
          (matricula) =>
              matricula.disciplinaId == disciplina.id &&
              matricula.semestreAtual,
        );

        // Exibe disciplinas que o aluno ainda não está matriculado no semestre atual
        // ou que o aluno já foi aprovado
        return !matriculaExiste ||
            matriculas.any(
              (matricula) =>
                  matricula.disciplinaId == disciplina.id &&
                  matricula.situacao != 'APROVADO',
            );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Filtra as disciplinas sempre que o curso for alterado
    _filtrarDisciplinas();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Rematrícula", style: TextStyle(fontSize: 20)),
            SizedBox(height: 2),
            Text(
              "Selecione um curso para visualizar as disciplinas disponíveis.",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(179, 65, 65, 65),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
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

            // Exibe as disciplinas disponíveis para matrícula
            Expanded(
              child: ListView(
                children: disciplinasDisponiveis.map<Widget>((disciplina) {
                  return CheckboxListTile(
                    title: Text(disciplina.nome),
                    subtitle: Text(
                      "Carga Horária: ${disciplina.cargaHoraria}h",
                    ),
                    value: disciplinasSelecionadas.contains(disciplina),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          disciplinasSelecionadas.add(disciplina);
                        } else {
                          disciplinasSelecionadas.remove(disciplina);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
            ),

            // Botão para confirmar matrícula
            ElevatedButton(
              onPressed: () {
                // Lógica para confirmar a matrícula nas disciplinas selecionadas
                if (disciplinasSelecionadas.isNotEmpty) {
                  // Adicionar lógica para confirmar a matrícula nas disciplinas
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Matrícula confirmada!'),
                      backgroundColor: Colors.green, // Fundo verde
                    ),
                  );

                  // Redireciona para a tela principal (ex: Dashboard)
                  Future.delayed(const Duration(seconds: 2), () {
                    Navigator.pushReplacementNamed(context, '/'); // Redirecionando para a tela principal
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Selecione ao menos uma disciplina.'),
                    ),
                  );
                }
              },
              child: const Text("Confirmar Matrícula"),
            ),
          ],
        ),
      ),
    );
  }
}