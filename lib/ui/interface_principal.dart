import 'package:flutter/material.dart';
import '../core/shared_preferences.dart';
import '../services/logica_jogo.dart';
import 'tabuleiro.dart';

class InterfacePrincipal extends StatefulWidget {
  const InterfacePrincipal({super.key});

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
      backgroundColor: const Color(0xFFF1F5F9),
      title: Padding(
        padding: const EdgeInsets.only(top: 31), // Adiciona o espaço superior
        child: const Text(
          'Jogo da Velha',
          style: TextStyle(
            fontSize: 24, 
            fontWeight: FontWeight.bold, 
            color: Color.fromARGB(255, 98, 138, 184),
          ),
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: _resetarPlacar,
          icon: const Icon(Icons.refresh),
          )
        ],
      ),
      backgroundColor: const Color(0xFFF1F5F9),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Placar',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 98, 138, 184)),
            ),
            Text(
              'X: $_pontosX | O: $_pontosO',
              style: const TextStyle(fontSize: 18),

            ),
            SizedBox(
              width: 600,
              height: 600,
              child: Tabuleiro(
                tabuleiro: _tabuleiro,
                aoTocar: _fazerJogada,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
