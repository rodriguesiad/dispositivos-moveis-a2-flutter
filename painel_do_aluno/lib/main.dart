import 'package:flutter/material.dart';
import 'package:painel_do_aluno/screens/portal_aluno_page.dart';
import 'package:painel_do_aluno/screens/rematricula_page.dart'; // Assumindo que RematrículaPage seja sua tela de rematrícula

void main() {
  runApp(PortalAlunoApp());
}

class PortalAlunoApp extends StatelessWidget {
  const PortalAlunoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal do Aluno',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      initialRoute: '/', // A tela inicial
      routes: {
        '/':
            (context) => const PortaldoAlunoPage(), // Tela inicial (seu portal)
        '/rematricula':
            (context) => const RematriculaPage(), // A tela de rematrícula
      },
    );
  }
}
