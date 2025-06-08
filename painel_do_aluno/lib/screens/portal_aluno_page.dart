import 'package:flutter/material.dart';
import 'package:painel_do_aluno/screens/boletim_page.dart';
import 'package:painel_do_aluno/screens/grade_curricular_page.dart';
import 'package:painel_do_aluno/screens/rematricula_page.dart';
import 'package:painel_do_aluno/screens/situacao_academica_page.dart';
import 'package:painel_do_aluno/screens/analise_curricular_page.dart';
import 'package:painel_do_aluno/widgets/card_portal_item.dart';
import 'package:painel_do_aluno/widgets/portal_app_header.dart';

class PortaldoAlunoPage extends StatelessWidget {
  const PortaldoAlunoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          PortalAppHeader(),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                CardPortalItem(
                  titulo: "BOLETIM (SEMESTRE ATUAL)",
                  subtitulo: "Desempenho nas disciplinas do semestre atual",
                  destino: BoletimPage(),
                ),
                CardPortalItem(
                  titulo: "GRADE CURRICULAR",
                  subtitulo:
                      "Selecione um curso e veja as disciplinas distribuídas por período.",
                  destino: GradeCurricularPage(),
                ),
                CardPortalItem(
                  titulo: "REMATRÍCULA ONLINE",
                  subtitulo: "Fazer a rematrícula conforme calendário acadêmico.",
                  destino: RematriculaPage(),
                ),
                CardPortalItem(
                  titulo: "SITUAÇÃO ACADÊMICA",
                  subtitulo: "Veja sua situação junto à secretaria.",
                  destino: SituacaoAcademicaPage(),
                ),
                CardPortalItem(
                  titulo: "ANÁLISE CURRICULAR",
                  subtitulo: "Análise curricular completa",
                  destino: AnaliseCurricularPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}