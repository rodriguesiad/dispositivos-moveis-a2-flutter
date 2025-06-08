import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/aluno.dart';
import 'package:painel_do_aluno/service/data_service.dart';

class SituacaoAcademicaPage extends StatelessWidget {
  const SituacaoAcademicaPage({super.key});

  Widget _buildCheckIcon(bool status) {
    return Icon(
      status ? Icons.check_circle : Icons.cancel,
      color: status ? Colors.green : Colors.red,
    );
  }

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
          return Scaffold(
            body: Center(child: Text('Erro ao carregar dados do aluno.')),
          );
        }

        final aluno = snapshot.data!;

        // Lista de documentos e seu status
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
          {'nome': 'Diploma/Certificado Registrado', 'status': aluno.simDiploma},
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
          appBar: AppBar(title: const Text("Situação Acadêmica")),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Informações do aluno
                Text(
                  'Nome: ${aluno.nome}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Número de Matrícula: ${aluno.numeroMatricula}',
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  'E-mail: ${aluno.email}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),

                const Text(
                  'Documentos:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // Lista de documentos e seus status (check ou X)
                ...documentos.map((doc) {
                  bool status = doc['status'] as bool;
                  return ListTile(
                    title: Text(doc['nome'] as String),
                    trailing: _buildCheckIcon(status),
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}