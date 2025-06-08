import 'package:flutter/material.dart';

class CardPortalItem extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final Widget destino;
  final VoidCallback? onTap;

  const CardPortalItem({
    super.key,
    required this.titulo,
    required this.subtitulo,
    required this.destino,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => destino));
          },

      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.only(bottom: 12),
        color: Colors.white,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          title: Text(
            titulo,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900],
            ),
          ),
          subtitle: Text(subtitulo),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
