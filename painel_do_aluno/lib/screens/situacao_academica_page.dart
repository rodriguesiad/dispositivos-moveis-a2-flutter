import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/aluno.dart';
import 'package:painel_do_aluno/widgets/aluno_info_widget.dart';
import 'package:painel_do_aluno/widgets/lista_documentos_widget.dart';
import 'package:painel_do_aluno/widgets/portal_app_header.dart';

class SituacaoAcademicaPage extends StatefulWidget {
  final Aluno aluno;
  const SituacaoAcademicaPage({super.key, required this.aluno});

  @override
  State<SituacaoAcademicaPage> createState() => _SituacaoAcademicaPageState();
}

class _SituacaoAcademicaPageState extends State<SituacaoAcademicaPage> {
  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?
  _snackBarController;

  late final List<Map<String, dynamic>> documentos;

  @override
  void initState() {
    super.initState();

    documentos = [
      {
        'nome': 'Carteira de Identidade/RG',
        'status': widget.aluno.simIdentidade,
      },
      {
        'nome': 'Certidão de Nascimento/Casamento',
        'status': widget.aluno.simCertNascimento,
      },
      {
        'nome': 'Histórico Escolar - Ensino Médio',
        'status': widget.aluno.simHistoricoEscolar,
      },
      {'nome': 'CPF (CIC)', 'status': true},
      {
        'nome': 'Diploma/Certificado Registrado',
        'status': widget.aluno.simDiploma,
      },
      {'nome': 'Comprovante de Vacina', 'status': widget.aluno.simCompVacina},
    ];

    final hasPendencia = documentos.any((d) => !(d['status'] as bool));

    if (hasPendencia) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _snackBarController = ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Pendência(s)! Você possui pendência de documento(s), favor procurar a secretaria.',
            ),
            backgroundColor: Colors.red,
            duration: Duration(days: 1),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _snackBarController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aluno = widget.aluno;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PortalAppHeader(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const BackButton(),
                const SizedBox(width: 8),
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
                      const SizedBox(height: 4),
                      const Text(
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AlunoInfoWidget(aluno: aluno),
                    const SizedBox(height: 20),
                    Text(
                      'Documentos:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.indigo[900],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListaDocumentosWidget(documentos: documentos),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
