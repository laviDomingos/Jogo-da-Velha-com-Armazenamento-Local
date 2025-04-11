import 'package:flutter/material.dart';
import '../core/shared_preferences.dart';
import '../services/logica_jogo.dart';
import 'tabuleiro.dart';

class InterfacePrincipal extends StatefulWidget {
  @override
  State<InterfacePrincipal> createState() => _InterfacePrincipalState();
}

class _InterfacePrincipalState extends State<InterfacePrincipal> {
  List<String> _tabuleiro = List.filled(9, '');
  bool _vezDoX = true;
  int _pontosX = 0;
  int _pontosO = 0;

  @override
  void initState() {
    super.initState();
    _carregarPontuacoes();
  }

  Future<void> _carregarPontuacoes() async {
    _pontosX = await SharedPrefs.carregarPontuacao('X');
    _pontosO = await SharedPrefs.carregarPontuacao('O');
    setState(() {});
  }

  void _fazerJogada(int index) {
    if (_tabuleiro[index] != '') return;

    setState(() {
      _tabuleiro[index] = _vezDoX ? 'X' : 'O';
      _vezDoX = !_vezDoX;
    });

    final vencedor = verificarVencedor(_tabuleiro);
    if (vencedor != null) {
      _mostrarVencedor(vencedor);
    } else if (!_tabuleiro.contains('')) {
      _mostrarEmpate();
    }
  }

  void _mostrarVencedor(String jogador) {
    if (jogador == 'X') {
      _pontosX++;
    } else {
      _pontosO++;
    }
    SharedPrefs.salvarPontuacao('X', _pontosX);
    SharedPrefs.salvarPontuacao('O', _pontosO);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Vitória!'),
        content: Text('Jogador $jogador venceu!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _reiniciarTabuleiro();
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  void _mostrarEmpate() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Empate!'),
        content: const Text('Ninguém venceu.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _reiniciarTabuleiro();
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  void _reiniciarTabuleiro() {
    setState(() {
      _tabuleiro = List.filled(9, '');
      _vezDoX = true;
    });
  }

  void _resetarPlacar() async {
    await SharedPrefs.limparPontuacoes();
    setState(() {
      _pontosX = 0;
      _pontosO = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jogo da Velha'),
        actions: [
          IconButton(
            onPressed: _resetarPlacar,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Column( // Contagem do placar
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Placar', style: TextStyle(fontSize: 20)),
          Text('X: $_pontosX | O: $_pontosO'),
          const SizedBox(height: 20),
          Tabuleiro(tabuleiro: _tabuleiro, aoTocar: _fazerJogada),
        ],
      ),
    );
  }
}
