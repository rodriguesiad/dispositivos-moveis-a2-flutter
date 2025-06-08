import 'package:flutter/material.dart';

class StatusDocumentoTile extends StatelessWidget {
  final String nome;
  final bool status;

  const StatusDocumentoTile({
    super.key,
    required this.nome,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(nome),
      trailing: Icon(
        status ? Icons.check_circle : Icons.cancel,
        color: status ? Colors.green : Colors.red,
      ),
    );
  }
}
