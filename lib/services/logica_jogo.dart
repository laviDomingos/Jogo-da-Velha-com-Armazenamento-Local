String? verificarVencedor(List<String> tabuleiro) {
  const combinacoesVencedoras = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  for (var combinacao in combinacoesVencedoras) {
    final a = combinacao[0], b = combinacao[1], c = combinacao[2];
    if (tabuleiro[a] != '' &&
        tabuleiro[a] == tabuleiro[b] &&
        tabuleiro[a] == tabuleiro[c]) {
      return tabuleiro[a];
    }
  }

  return null;
}
