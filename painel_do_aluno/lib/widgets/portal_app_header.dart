import 'package:flutter/material.dart';

class PortalAppHeader extends StatelessWidget {
  const PortalAppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo[900],
      padding: const EdgeInsets.symmetric(vertical: 16),
      alignment: Alignment.center,
      child: const Text(
        'Portal do Aluno',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}