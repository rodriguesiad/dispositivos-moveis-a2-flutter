import 'package:flutter/material.dart';
import 'package:painel_do_aluno/service/data_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  final dataService = DataService();

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final senha = _senhaController.text;

      try {
        final aluno = await dataService.autenticarAluno(email, senha);

        if (aluno != null) {
          Navigator.pushReplacementNamed(context, '/home', arguments: aluno);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('E-mail ou senha inválidos'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro: ${e.toString()}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Portal do Aluno",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  validator:
                      (value) => value!.isEmpty ? 'Informe o e-mail' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _senhaController,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  obscureText: true,
                  validator:
                      (value) => value!.isEmpty ? 'Informe a senha' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(onPressed: _login, child: const Text("Entrar")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
