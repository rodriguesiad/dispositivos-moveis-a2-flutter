import 'package:flutter/material.dart';
import 'package:painel_do_aluno/models/aluno.dart';
import 'package:painel_do_aluno/service/data_service.dart';

class SituacaoAcademicaPage extends StatelessWidget {
  const SituacaoAcademicaPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Carrega os dados do aluno a partir do DataService
    final DataService dataService = DataService();
    final Aluno aluno = dataService.carregarAluno();

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
      {'nome': 'CPF (CIC)', 'status': true}, // CPF sempre verdadeiro
      {'nome': 'Diploma/Certificado Registrado', 'status': aluno.simDiploma},
      {'nome': 'Comprovante de Vacina', 'status': aluno.simCompVacina},
    ];

    // Função para exibir o ícone de check ou X
    Widget _buildCheckIcon(bool status) {
      return Icon(
        status ? Icons.check_circle : Icons.cancel,
        color: status ? Colors.green : Colors.red,
      );
    }

    // Verifica se há documentos pendentes (status false)
    final hasPendencia = documentos.any((doc) => !(doc['status'] as bool));

    if (hasPendencia) {
      // Exibe o SnackBar se houver pendência de documentos
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Pendência(s)! Você possui pendência de documento(s), favor procurar a secretaria.',
            ),
            backgroundColor: Colors.red,
            duration: const Duration(days: 365), // Duração infinita (quase)
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

            // Lista de documentos
            const Text(
              'Documentos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Lista de documentos e seus status (check ou X)
            ...documentos.map((doc) {
              bool status =
                  doc['status'] as bool; // Garantir que o status é booleano
              return ListTile(
                title: Text(
                  doc['nome'] as String,
                ), // Garantir que o nome seja uma string
                trailing: _buildCheckIcon(status),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
