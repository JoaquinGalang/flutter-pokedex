import 'package:flutter/material.dart';

class PokeballLoadingIndicator extends StatelessWidget {
  const PokeballLoadingIndicator({
    super.key,
    this.size = 80,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'images/pokedex_loading.gif',
        width: size,
      ),
    );
  }
}