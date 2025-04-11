import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<void> salvarPontuacao(String jogador, int pontos) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('pontos_$jogador', pontos);
  }

  static Future<int> carregarPontuacao(String jogador) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('pontos_$jogador') ?? 0;
  }

  static Future<void> limparPontuacoes() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('pontos_X');
    await prefs.remove('pontos_O');
  }
}
