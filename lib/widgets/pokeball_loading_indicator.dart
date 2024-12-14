import 'package:flutter/material.dart';

class PokeballLoadingIndicator extends StatelessWidget {
  const PokeballLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'images/pokedex_loading.gif',
        width: 80,
      ),
    );
  }
}