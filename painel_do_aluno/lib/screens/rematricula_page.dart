// paginas/pagina1.dart
import 'package:flutter/material.dart';

class RematriculaPage extends StatelessWidget {
  const RematriculaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Boletim Acadêmico", style: TextStyle(fontSize: 20)),
            SizedBox(height: 2),
            Text(
              "Selecione o curso abaixo",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(179, 65, 65, 65),
              ),
            ),
          ],
        ),
      ),
      body: const Center(child: Text("Conteúdo da Página 1")),
    );
  }
}
