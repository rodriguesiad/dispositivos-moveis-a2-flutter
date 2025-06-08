import 'package:flutter/material.dart';
import 'package:painel_do_aluno/screens/portal_aluno_page.dart';
import 'package:painel_do_aluno/screens/rematricula_page.dart'; 
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
      initialRoute: '/', 
      routes: {
        '/':
            (context) => const PortaldoAlunoPage(), 
        '/rematricula':
            (context) => const RematriculaPage(),
      },
    );
  }
}
