// paginas/pagina1.dart
import 'package:flutter/material.dart';

class Pagina3 extends StatelessWidget {
  const Pagina3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Página 1")),
      body: const Center(child: Text("Conteúdo da Página 1")),
    );
  }
}
