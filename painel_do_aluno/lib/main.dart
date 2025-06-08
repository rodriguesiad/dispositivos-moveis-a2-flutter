import 'package:flutter/material.dart';
import 'package:painel_do_aluno/screens/login_page.dart';
import 'package:painel_do_aluno/screens/portal_aluno_page.dart';
import 'package:painel_do_aluno/screens/rematricula_page.dart';
import 'package:painel_do_aluno/models/aluno.dart';

void main() {
  runApp(const PortalAlunoApp());
}

class PortalAlunoApp extends StatelessWidget {
  const PortalAlunoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.indigo,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/home': (context) => const PortaldoAlunoPage(),
      },
    );
  }
}
