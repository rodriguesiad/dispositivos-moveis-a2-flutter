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

  // Função para agrupar disciplinas por período, filtrando pelo curso selecionado
  Map<String, List<Disciplina>> _agruparDisciplinasPorPeriodo() {
    Map<String, List<Disciplina>> agrupamento = {};

    // Filtra as disciplinas para o curso selecionado
    var disciplinasFiltradas = cursoSelecionado == null
        ? []
        : disciplinas.where((disciplina) => disciplina.cursoId == cursoSelecionado).toList();

    for (var disciplina in disciplinasFiltradas) {
      // Se o período já existe, adiciona a disciplina, senão cria a lista
      if (agrupamento.containsKey(disciplina.periodo)) {
        agrupamento[disciplina.periodo]?.add(disciplina);
      } else {
        agrupamento[disciplina.periodo] = [disciplina];
      }
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
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text("Carga Horária: ${d.cargaHoraria}h"),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Agrupa as disciplinas por período
    final disciplinasPorPeriodo = _agruparDisciplinasPorPeriodo();

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
                children: disciplinasPorPeriodo.keys.map<Widget>((periodo) {
                  // Para cada período, cria uma seção com o título do período e as disciplinas associadas a ele
                  var disciplinasDoPeriodo = disciplinasPorPeriodo[periodo]!;
                  return ExpansionTile(
                    title: Text("Período $periodo"),
                    children: disciplinasDoPeriodo.map<Widget>((disciplina) => _buildCard(disciplina)).toList(),
                  );
                }).toList(),
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