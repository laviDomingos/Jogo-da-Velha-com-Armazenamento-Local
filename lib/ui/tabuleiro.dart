import 'package:flutter/material.dart';

class Tabuleiro extends StatelessWidget {
  final List<String> tabuleiro;
  final void Function(int) aoTocar;

  const Tabuleiro({required this.tabuleiro, required this.aoTocar, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 9,
      padding: const EdgeInsets.all(16),
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () => aoTocar(index),
          child: Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                tabuleiro[index],
                style: const TextStyle(
                    fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }
}
