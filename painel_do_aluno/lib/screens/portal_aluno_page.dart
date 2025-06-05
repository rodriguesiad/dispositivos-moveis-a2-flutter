import 'package:flutter/material.dart';
import 'package:painel_do_aluno/screens/boletim_page.dart';
import 'package:painel_do_aluno/screens/grade_curricular_page.dart';
import 'package:painel_do_aluno/screens/rematricula_page.dart';
import 'package:painel_do_aluno/screens/pagina4.dart';
import 'package:painel_do_aluno/screens/analise_curricular_page.dart';

class PortaldoAlunoPage extends StatefulWidget {
  const PortaldoAlunoPage({super.key});

  @override
  State<PortaldoAlunoPage> createState() => _PortaldoAlunoPageState();
}

class _PortaldoAlunoPageState extends State<PortaldoAlunoPage> {
  String termoBusca = '';

  @override
  void initState() {
    super.initState();
  }

  Widget _buildCard(
    BuildContext context,
    String titulo,
    String subtitulo,
    Widget destino,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => destino));
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(bottom: 12),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          title: Text(
            titulo,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(subtitulo),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: const Text(
          "Portal do Aluno",
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildCard(
            context,
            "BOLETIM (SEMESTRE ATUAL)",
            "Desempenho nas disciplinas do semestre atual",
            const BoletimPage(),
          ),
          _buildCard(
            context,
            "Grade Curricular",
            "Selecione um curso e veja as disciplinas distribuídas por período.",
            const GradeCurricularPage(),
          ),
          _buildCard(
            context,
            "Rematrícula Online",
            "Fazer a rematrícula nos semestres posteriores, conforme calendário acadêmico. Emissão da declaração de vínculo.",
            const RematriculaPage(),
          ),
          _buildCard(
            context,
            "Situação Acadêmica",
            "Veja a sua situação junto a secretaria e demais departamentos da unitins.",
            const Pagina4(),
          ),
          _buildCard(
            context,
            "Análise Curricular",
            "Análise curricular completa",
            const AnaliseCurricularPage(),
          ),
        ],
      ),
    );
  }
}
