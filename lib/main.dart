import 'package:flutter/material.dart';
import 'ui/interface_principal.dart';

void main() {
  runApp(JogoDaVelhaApp());
}

class JogoDaVelhaApp extends StatelessWidget {
  const JogoDaVelhaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Velha',
      home: InterfacePrincipal(),
      debugShowCheckedModeBanner: false,
    );
  }
}
