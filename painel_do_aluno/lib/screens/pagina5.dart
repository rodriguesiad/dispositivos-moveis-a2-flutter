// paginas/pagina1.dart
import 'package:flutter/material.dart';

class Pagina5 extends StatelessWidget {
  const Pagina5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Página 1")),
      body: const Center(child: Text("Conteúdo da Página 1")),
    );
  }
}
