import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/aluno.dart';
import 'package:painel_do_aluno/service/data_service.dart';
import 'package:painel_do_aluno/widgets/aluno_info_widget.dart';
import 'package:painel_do_aluno/widgets/lista_documentos_widget.dart';
import 'package:painel_do_aluno/widgets/portal_app_header.dart';

class SituacaoAcademicaPage extends StatelessWidget {
  const SituacaoAcademicaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DataService dataService = DataService();

    return FutureBuilder<Aluno>(
      future: dataService.carregarAluno(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Erro ao carregar dados do aluno.')),
          );
        }

        final aluno = snapshot.data!;

        final documentos = [
          {'nome': 'Carteira de Identidade/RG', 'status': aluno.simIdentidade},
          {
            'nome': 'Certidão de Nascimento/Casamento',
            'status': aluno.simCertNascimento,
          },
          {
            'nome': 'Histórico Escolar - Ensino Médio',
            'status': aluno.simHistoricoEscolar,
          },
          {'nome': 'CPF (CIC)', 'status': true},
          {
            'nome': 'Diploma/Certificado Registrado',
            'status': aluno.simDiploma,
          },
          {'nome': 'Comprovante de Vacina', 'status': aluno.simCompVacina},
        ];

        final hasPendencia = documentos.any((doc) => !(doc['status'] as bool));

        if (hasPendencia) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Pendência(s)! Você possui pendência de documento(s), favor procurar a secretaria.',
                ),
                backgroundColor: Colors.red,
                duration: Duration(days: 365),
              ),
            );
          });
        }

        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            "Situação Acadêmica",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo[900],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Consulte abaixo suas informações e documentos pendentes.",
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AlunoInfoWidget(aluno: aluno),
                      const SizedBox(height: 20),
                      const Text(
                        'Documentos:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ListaDocumentosWidget(documentos: documentos),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
