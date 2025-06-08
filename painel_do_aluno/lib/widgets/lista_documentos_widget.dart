import 'package:flutter/material.dart';
import 'package:painel_do_aluno/widgets/status_documento_tile.dart';

class ListaDocumentosWidget extends StatelessWidget {
  final List<Map<String, dynamic>> documentos;

  const ListaDocumentosWidget({super.key, required this.documentos});

  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          documentos.expand((doc) {
            return [
              StatusDocumentoTile(nome: doc['nome'], status: doc['status']),
              const Divider(height: 1, thickness: 1),
            ];
          }).toList(),
    );
  }
}
